import 'package:food_api/domain/entities/user_entity.dart';
import 'package:food_api/domain/repositories/user_repository.dart';
import 'package:food_api/domain/value_objects/email.dart';
import 'package:food_api/domain/value_objects/user_id.dart';

class UpdateUserUseCase {
  final UserRepository _userRepository;
  
  UpdateUserUseCase(this._userRepository);
  
  Future<UserEntity> execute({
    required String uid,
    String? email,
    String? name,
    String? surname,
    String? phone,
    DateTime? dateOfBirth,
  }) async {

    final userId = UserId(uid);
    final existingUser = await _userRepository.getUserById(userId);

    if (existingUser == null) {
      throw Exception('User not found');
    }
    
    final updatedUser = UserEntity(
      id: userId,
      email: email != null ? Email(email) : existingUser.email,
      name: name ?? existingUser.name,
      surname: surname ?? existingUser.surname,
      phone: phone ?? existingUser.phone,
      dateOfBirth: dateOfBirth ?? existingUser.dateOfBirth,
      createdAt: existingUser.createdAt,
    );
    
    await _userRepository.updateUser(updatedUser);
    return updatedUser;
  
  }
}
