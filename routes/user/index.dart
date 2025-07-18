import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/application/controllers/user_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    final controller = context.read<UserController>();
    return controller.registerUser(context);
  }
  

  return Response(statusCode: 405, body: 'Method not allowed');
}
