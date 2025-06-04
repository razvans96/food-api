import 'package:food_api/models/user.dart';
import 'package:food_api/repositories/user_repository.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();

  Future<void> registerUser(User user) async {
    // Aquí debería añadir validaciones extra más adelante

    await _userRepository.insertUser(user);
  }
}
