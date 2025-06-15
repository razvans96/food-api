import 'package:food_api/domain/entities/user_entity.dart';
import 'package:food_api/domain/value_objects/email.dart';
import 'package:food_api/domain/value_objects/user_id.dart';

abstract class UserRepository {
  /// Obtiene un usuario por su ID
  Future<UserEntity?> getUserById(UserId userId);
  
  /// Obtiene un usuario por su email
  Future<UserEntity?> getUserByEmail(Email email);
  
  /// Verifica si existe un usuario con el ID dado
  Future<bool> existsById(UserId userId);
  
  /// Verifica si existe un usuario con el email dado
  Future<bool> existsByEmail(Email email);
  
  /// Guarda un nuevo usuario
  Future<void> saveUser(UserEntity user);
  
  /// Actualiza un usuario existente
  Future<void> updateUser(UserEntity user);
  
  /// Elimina un usuario por su ID
  Future<void> deleteUser(UserId userId);
  
  /// Obtiene todos los usuarios (para admin)
  Future<List<UserEntity>> getAllUsers();
}
