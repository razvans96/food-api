import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/application/controllers/user_controller.dart';

Future<Response> onRequest(RequestContext context, String uid) async {
  if (context.request.method == HttpMethod.get) {
    final controller = context.read<UserController>();
    return controller.getUserByUid(context, uid);
  }
  
  
  return Response(statusCode: 405, body: 'Method not allowed');
}
