import 'package:food_api/domain/entities/user_entity.dart';
import 'package:food_api/domain/repositories/user_repository.dart';
import 'package:food_api/domain/value_objects/email.dart';
import 'package:food_api/domain/value_objects/user_id.dart';

class CreateUserUseCase {
  final UserRepository _userRepository;

  CreateUserUseCase(this._userRepository);

  Future<UserEntity> execute({
    required String uid,
    required String email,
    required String name,
    required String surname,
    required DateTime dateOfBirth,
    String? phone,
    List<String>? dietaryRestrictions,
  }) async {
    final userId = UserId(uid);
    final userEmail = Email(email);

    final existingUser = await _userRepository.existsById(userId);
    if (existingUser) {
      throw Exception('User with ID $uid already exists');
    }

    final user = UserEntity(
      id: userId,
      email: userEmail,
      name: name,
      surname: surname,
      dateOfBirth: dateOfBirth,
      phone: phone,
      dietaryRestrictions: dietaryRestrictions,
    );

    final existingEmail = await _userRepository.existsByEmail(userEmail);
    if (existingEmail) {
      await _userRepository.updateUser(user);
    }

    await _userRepository.saveUser(user);
    return user;
  }
}
