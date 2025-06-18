import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/shared/utils/app_check_service.dart';

Handler appCheckMiddleware(Handler handler) {
  return (context) async {
    final token = context.request.headers['x-firebase-appcheck'];
    final platform = context.request.headers['x-app-platform'];

    if (token == null || token.isEmpty) {
      return Response(statusCode: 401, body: 'App Check token missing');
    }
    if (platform == null || platform.isEmpty) {
      return Response(statusCode: 401, body: 'X-App-Platform header missing');
    }

    final validator = AppCheckService(platform: platform);
    final isValid = await validator.isValid(token);

    if (!isValid) {
      return Response(statusCode: 401, body: 'No autorizado.');
    }

    return handler(context);
  };
}
