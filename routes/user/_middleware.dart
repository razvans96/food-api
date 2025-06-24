import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/shared/middleware/token_verify_middleware.dart';

Handler middleware(Handler handler) {
  return handler.use(tokenVerifyMiddleware());
}
