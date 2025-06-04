import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/controllers/user_controller.dart';

final _controller = UserController();

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _controller.registerUser(context);
  }

  return Response.json(
    statusCode: 405,
    body: {'error': 'Método no permitido.'},
  );
}
