import 'package:food_api/domain/entities/user_entity.dart';
import 'package:food_api/domain/repositories/user_repository.dart';
import 'package:food_api/domain/value_objects/user_id.dart';

class GetUserByIdUseCase {
  final UserRepository _userRepository;

  GetUserByIdUseCase(this._userRepository);

  Future<UserEntity?> execute(String uid) async {
    final userId = UserId(uid);
    return _userRepository.getUserById(userId);
  }
}
