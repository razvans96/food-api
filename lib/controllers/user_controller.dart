import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/models/user.dart';
import 'package:food_api/services/user_service.dart';

class UserController {
  final UserService _userService = UserService();

  Future<Response> registerUser(RequestContext context) async {
    
    final user = User.fromJson(await context.request.json() as Map<String, dynamic>);

    if (user.userUid.isEmpty || user.userEmail.isEmpty) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Faltan campos obligatorios.'},
      );
    }

    try {
      await _userService.registerUser(user);
      return Response.json(body: {'message': 'Usuario registrado correctamente.'});
    } catch (e) {
      return Response.json(
        statusCode: 500,
        body: {'error': 'Error al registrar usuario: $e'},
      );
    }
  }
}
