import 'package:food_api/config/openfood_config.dart';
import 'package:food_api/models/simple_product.dart';
import 'package:openfoodfacts/openfoodfacts.dart';


class SimpleProductService {
  static Future<List<SimpleProduct>> searchProductByName(String productName) async {
    configureOpenFoodFacts();

    final searchConfig = ProductSearchQueryConfiguration(
      parametersList: [SearchTerms(terms: [productName])],
      fields: [ProductField.NAME, ProductField.BRANDS],
      version: ProductQueryVersion.v3,
    );

    final result = await OpenFoodAPIClient.searchProducts(
      OpenFoodAPIConfiguration.globalUser,
      searchConfig,
      uriHelper: uriHelperFoodTest,
    );

    return result.products?.map((p) {
      return SimpleProduct(
        name: p.productName,
        brands: p.brands,
      );
    }).toList() ?? [];
  }

  static Future<SimpleProduct> searchProductByBarcode(String barcode) async {
    configureOpenFoodFacts();

    final queryConfig = ProductQueryConfiguration(
      barcode,
      fields: [ProductField.NAME, ProductField.BRANDS],
      version: ProductQueryVersion.v3,
    );

    final productResult = await OpenFoodAPIClient.getProductV3(
      queryConfig,
      user: OpenFoodAPIConfiguration.globalUser,
      uriHelper: uriHelperFoodTest,
    );

    return SimpleProduct(
      name: productResult.product?.productName ?? 'Producto no encontrado',
      brands: productResult.product?.brands ?? 'Marca no disponible',
    );
  }
}
