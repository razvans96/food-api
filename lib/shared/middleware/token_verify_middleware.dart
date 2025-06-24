import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/shared/utils/firebase_token_validator.dart';

Middleware tokenVerifyMiddleware() {
  return (handler) {
    return (context) async {
      final request = context.request;
      
      final authHeader = request.headers['Authorization'];
      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response(statusCode: 401, body: 'Token requerido');
      }
      
      final token = authHeader.substring(7);
      
      final user = await FirebaseTokenValidator.validateToken(token);
      if (user == null) {
        return Response(statusCode: 401, body: 'Token inválido');
      }
      
      return handler(context);
    };
  };
}
