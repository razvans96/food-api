import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/application/controllers/product_controller.dart';
import 'package:food_api/application/controllers/user_controller.dart';
import 'package:food_api/domain/repositories/product_repository.dart';
import 'package:food_api/domain/repositories/user_repository.dart';
import 'package:food_api/domain/use_cases/get_product_by_barcode_use_case.dart';
import 'package:food_api/domain/use_cases/save_product_use_case.dart';
import 'package:food_api/domain/use_cases/search_products_use_case.dart';
import 'package:food_api/infrastructure/repositories/product_repository_impl.dart';
import 'package:food_api/infrastructure/repositories/user_repository_impl.dart';

Handler dependencyInjectionMiddleware(Handler handler) {
  return handler
    .use(requestLogger())
    .use(_userControllerProvider())
    .use(_userRepositoryProvider())
    .use(_productControllerProvider())
    .use(_productUseCasesProvider())
    .use(_productRepositoryProvider());
}

Middleware _userRepositoryProvider() {
  return provider<UserRepository>(
    (context) => UserRepositoryImpl(),
  );
}


Middleware _userControllerProvider() {
  return provider<UserController>(
    (context) => UserController(
      context.read<UserRepository>(),
    ),
  );
}


Middleware _productRepositoryProvider() {
  return provider<ProductRepository>(
    (context) => ProductRepositoryImpl(),
  );
}

Middleware _productUseCasesProvider() {
  return (handler) {
    return handler
        .use(_getProductByBarcodeUseCaseProvider())
        .use(_searchProductsUseCaseProvider())
        .use(_saveProductUseCaseProvider());
  };
}

Middleware _getProductByBarcodeUseCaseProvider() {
  return provider<GetProductByBarcodeUseCase>(
    (context) => GetProductByBarcodeUseCase(
      context.read<ProductRepository>(),
    ),
  );
}

Middleware _searchProductsUseCaseProvider() {
  return provider<SearchProductsUseCase>(
    (context) => SearchProductsUseCase(
      context.read<ProductRepository>(),
    ),
  );
}

Middleware _saveProductUseCaseProvider() {
  return provider<SaveProductUseCase>(
    (context) => SaveProductUseCase(
      context.read<ProductRepository>() as ProductRepositoryImpl,
    ),
  );
}

Middleware _productControllerProvider() {
  return provider<ProductController>(
    (context) => ProductController(
      context.read<GetProductByBarcodeUseCase>(),
      context.read<SearchProductsUseCase>(),
      context.read<SaveProductUseCase>(),
    ),
  );
}
