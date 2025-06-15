import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/application/controllers/user_controller.dart';
import 'package:food_api/domain/repositories/user_repository.dart';
import 'package:food_api/infrastructure/repositories/user_repository_impl.dart';

Handler dependencyInjectionMiddleware(Handler handler) {
  return handler
    .use(requestLogger())
    .use(_userControllerProvider())
    .use(_userRepositoryProvider());
}

Middleware _userRepositoryProvider() {
  return provider<UserRepository>(
    (context) => UserRepositoryImpl(),
  );
}


Middleware _userControllerProvider() {
  return provider<UserController>(
    (context) => UserController(
      context.read<UserRepository>(), // Inyecta el repositorio
    ),
  );
}
