import 'package:food_api/config/openfood_config.dart';
import 'package:food_api/models/product_food.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductFoodService {

  static Future<List<ProductFood>> searchProductByName(String productName) async {
    configureOpenFoodFacts();

    final searchConfig = ProductSearchQueryConfiguration(
      parametersList: [SearchTerms(terms: [productName])],
      fields: [
        ProductField.NAME,
        ProductField.BRANDS,
        ProductField.QUANTITY,
        ProductField.NUTRISCORE,
        ProductField.ECOSCORE_GRADE,
        ProductField.IMAGE_FRONT_SMALL_URL,
        ProductField.NOVA_GROUP,
      ],
      version: ProductQueryVersion.v3,
    );

    final result = await OpenFoodAPIClient.searchProducts(
      OpenFoodAPIConfiguration.globalUser,
      searchConfig,
      uriHelper: uriHelperFoodTest,
    );


    return result.products?.map((p) {
      return ProductFood(
        name: p.productName,
        brand: p.brands,
        quantity: p.quantity ?? '',
        nutriscoreGrade: p.nutriscore,
        ecoscoreGrade: p.ecoscoreGrade,
        imageUrl: p.imageFrontSmallUrl,
        novaGroup: p.novaGroup,
      );
    }).toList() ?? [];
  }


  static Future<ProductFood> searchProductByBarcode(String barcode) async {
    configureOpenFoodFacts();

    final queryConfig = ProductQueryConfiguration(
      barcode,
      fields: [
        ProductField.NAME,
        ProductField.BRANDS,
        ProductField.QUANTITY,
        ProductField.NUTRISCORE,
        ProductField.ECOSCORE_GRADE,
        ProductField.IMAGE_FRONT_SMALL_URL,
        ProductField.NOVA_GROUP,
      ],
      version: ProductQueryVersion.v3,
    );

    final productResult = await OpenFoodAPIClient.getProductV3(
      queryConfig,
      user: OpenFoodAPIConfiguration.globalUser,
      uriHelper: uriHelperFoodTest,
    );

    final p = productResult.product;

    return ProductFood(
      name: p?.productName ?? 'Producto no encontrado',
      brand: p?.brands ?? 'Marca no disponible',
      quantity: p?.quantity ?? '',
      nutriscoreGrade: p?.nutriscore,
      ecoscoreGrade: p?.ecoscoreGrade,
      imageUrl: p?.imageFrontSmallUrl,
      novaGroup: p?.novaGroup,
    );
  }
}
