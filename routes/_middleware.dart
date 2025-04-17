
import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/middleware/cors_middleware.dart';

Handler middleware(Handler handler) {  
  return handler.use(corsMiddleware);
}
