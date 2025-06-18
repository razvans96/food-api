import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/domain/repositories/product_repository.dart';
import 'package:food_api/domain/value_objects/barcode.dart';

class GetProductByBarcodeUseCase {
  final ProductRepository _repository;

  GetProductByBarcodeUseCase(this._repository);

  Future<ProductEntity?> execute(String barcodeValue) async {
    try {
      final barcode = Barcode(barcodeValue);
      
      final product = await _repository.getProductByBarcode(barcode);
      
      return product;
    } catch (e) {
      rethrow;
    }
  }
}
