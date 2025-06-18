import 'package:food_api/application/dto/openfoodfacts_dto.dart';
import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/domain/repositories/product_repository.dart';
import 'package:food_api/domain/value_objects/barcode.dart';
import 'package:food_api/infrastructure/config/openfood_config.dart';
import 'package:food_api/infrastructure/database/postgres_connection_manager.dart';
import 'package:food_api/infrastructure/models/product_model.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductRepositoryImpl implements ProductRepository {
  

  @override
  Future<ProductEntity?> getProductByBarcode(Barcode barcode) async {
    try {

      final productFromDb = await _getProductFromDatabase(barcode);
      if (productFromDb != null) {
        return productFromDb;
      }

      final productFromApi = await _getProductFromOpenFoodFacts(barcode);
      if (productFromApi != null) {
        
        await _saveProductToDatabase(productFromApi);
        return productFromApi;
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductEntity>> searchProductsByName(String name) async {
    try {

      configureOpenFoodFacts();
      
      final searchConfig = ProductSearchQueryConfiguration(
        parametersList: [SearchTerms(terms: [name])],
        fields: [
          ProductField.BARCODE,
          ProductField.NAME,
          ProductField.BRANDS,
          ProductField.QUANTITY,
          ProductField.IMAGE_FRONT_SMALL_URL,
          ProductField.NUTRISCORE,
          ProductField.ECOSCORE_GRADE,
          ProductField.NOVA_GROUP,
          ProductField.NUTRIMENTS,
          ProductField.INGREDIENTS_TAGS,
          ProductField.ALLERGENS,
          ProductField.ADDITIVES,
          ProductField.CATEGORIES_TAGS,
        ],
        version: ProductQueryVersion.v3,
      );

      final result = await OpenFoodAPIClient.searchProducts(
        OpenFoodAPIConfiguration.globalUser,
        searchConfig,
        uriHelper: uriHelperFoodTest,
      );

      if (result.products?.isNotEmpty ?? false) {
        final entities = result.products!
            .map(OpenFoodFactsProductDto.fromOpenFoodFactsSDK)
            .map((dto) => dto.toDomain())
            .toList();
        
        return entities;
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> productExists(Barcode barcode) async {
    try {
      final connection = await PostgresConnectionManager.getConnection();
      final result = await connection.execute(
        r'SELECT 1 FROM products WHERE product_barcode = $1 LIMIT 1',
        parameters: [barcode.value],
      );
      return result.isNotEmpty;
    } catch (e) {
      return false;
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    try {
      final connection = await PostgresConnectionManager.getConnection();
      final result = await connection.execute(
        '''
          SELECT * FROM products 
          WHERE product_nutriscore_grade IN ('a', 'b') 
          ORDER BY product_created_at DESC 
          LIMIT 10''',
      );

      return result
        .map((row) => ProductModel.fromPostgres(row.toColumnMap())) 
        .map((model) => model.toDomain())
        .toList();
    } catch (e) {
      return [];
    }
  }


  Future<bool> saveProduct(ProductEntity product) async {
    try {
      await _saveProductToDatabase(product);
      return true;
    } catch (e) {
      return false;
    }
  }

  
  Future<ProductEntity?> _getProductFromDatabase(Barcode barcode) async {
    try {
      final connection = await PostgresConnectionManager.getConnection();
      final result = await connection.execute(
        r'SELECT * FROM products WHERE product_barcode = $1',
        parameters: [barcode.value],
      );

      if (result.isNotEmpty) {
        final model = ProductModel.fromPostgres(result.first.toColumnMap());
        return model.toDomain();
      }
      return null;
    } catch (e) {
      return null;
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

  Future<ProductEntity?> _getProductFromOpenFoodFacts(Barcode barcode) async {
    try {
      configureOpenFoodFacts();
      
      final queryConfig = ProductQueryConfiguration(
        barcode.value,
        fields: [
          ProductField.BARCODE,
          ProductField.NAME,
          ProductField.BRANDS,
          ProductField.QUANTITY,
          ProductField.IMAGE_FRONT_SMALL_URL,
          ProductField.NUTRISCORE,
          ProductField.ECOSCORE_GRADE,
          ProductField.NOVA_GROUP,
          ProductField.NUTRIMENTS,
          ProductField.INGREDIENTS_TAGS,
          ProductField.ALLERGENS,
          ProductField.ADDITIVES,
          ProductField.CATEGORIES_TAGS,
        ],
        version: ProductQueryVersion.v3,
      );

      final productResult = await OpenFoodAPIClient.getProductV3(
        queryConfig,
        user: OpenFoodAPIConfiguration.globalUser,
        uriHelper: uriHelperFoodTest,
      );

      if (productResult.product != null) {
        final dto = OpenFoodFactsProductDto.fromOpenFoodFactsSDK(productResult.product!);
        return dto.toDomain();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveProductToDatabase(ProductEntity product) async {
    if (product.barcode == null) {
      throw Exception('No se puede guardar producto sin código de barras');
    }

    try {
      final connection = await PostgresConnectionManager.getConnection();
      final model = ProductModel.fromDomain(product);
      
      await connection.execute(
        r'''
            INSERT INTO products (
              product_barcode, product_name, product_brand, product_quantity,
              product_nutriscore_grade, product_ecoscore_grade, product_image_url,
              product_nova_group, product_created_at, product_updated_at,
              product_nutritional_data, product_ingredients, product_allergens,
              product_additives, product_categories
            ) VALUES (
              $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15
            ) ON CONFLICT (product_barcode) 
              DO UPDATE SET
                product_name = EXCLUDED.product_name,
                product_brand = EXCLUDED.product_brand,
                product_quantity = EXCLUDED.product_quantity,
                product_nutriscore_grade = EXCLUDED.product_nutriscore_grade,
                product_ecoscore_grade = EXCLUDED.product_ecoscore_grade,
                product_image_url = EXCLUDED.product_image_url,
                product_nova_group = EXCLUDED.product_nova_group,
                product_updated_at = NOW(),
                product_nutritional_data = EXCLUDED.product_nutritional_data,
                product_ingredients = EXCLUDED.product_ingredients,
                product_allergens = EXCLUDED.product_allergens,
                product_additives = EXCLUDED.product_additives,
                product_categories = EXCLUDED.product_categories''',
        parameters: [
          model.productBarcode,
          model.productName,
          model.productBrand,
          model.productQuantity,
          model.productNutriscoreGrade,
          model.productEcoscoreGrade,
          model.productImageUrl,
          model.productNovaGroup,
          model.productCreatedAt,
          model.productUpdatedAt,
          model.productNutritionalData,
          model.productIngredients,
          model.productAllergens,
          model.productAdditives,
          model.productCategories,
        ],
      );
    } catch (e) {
      rethrow;
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

}
