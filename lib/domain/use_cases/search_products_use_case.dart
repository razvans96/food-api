import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/domain/repositories/product_repository.dart';

class SearchProductsUseCase {
  final ProductRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<List<ProductEntity>> execute(String searchTerm) async {
    final products = await _repository.searchProductsByName(searchTerm.trim());
    return products;
  }
}
