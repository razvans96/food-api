import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/infrastructure/repositories/product_repository_impl.dart';

class SaveProductUseCase {
  final ProductRepositoryImpl _repository;

  SaveProductUseCase(this._repository);

  Future<bool> execute(ProductEntity product) async {
    final success = await _repository.saveProduct(product);
    return success;
  }
}
