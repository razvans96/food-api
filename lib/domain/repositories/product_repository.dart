import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/domain/value_objects/barcode.dart';

abstract class ProductRepository {
  
  Future<List<ProductEntity>> searchProductsByName(String name);
  
  Future<ProductEntity?> getProductByBarcode(Barcode barcode);
  
  Future<bool> productExists(Barcode barcode);
  
  Future<List<ProductEntity>> getFeaturedProducts();
  
}
