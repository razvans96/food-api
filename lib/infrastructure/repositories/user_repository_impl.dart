import 'package:food_api/domain/entities/user_entity.dart';
import 'package:food_api/domain/interfaces/database_connection_pool.dart';
import 'package:food_api/domain/repositories/user_repository.dart';
import 'package:food_api/domain/value_objects/email.dart';
import 'package:food_api/domain/value_objects/user_id.dart';
import 'package:food_api/infrastructure/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final IDatabaseConnectionPool _pool;

  UserRepositoryImpl(this._pool);

  @override
  Future<UserEntity?> getUserById(UserId userId) async {
    return _pool.withConnection((connection) async {
      final result = await connection.execute(
        r'''
        SELECT user_uid, user_email, user_name, user_surname, user_phone, user_dob, user_created_at
        FROM users
        WHERE user_uid = $1
        ''',
        parameters: [userId.value],
      );

      if (result.isEmpty) return null;

      final userModel = UserModel.fromDatabaseRow(result.first);
      return userModel.toDomain();
    });
  }

  @override
  Future<UserEntity?> getUserByEmail(Email email) async {
    return _pool.withConnection((connection) async {
      final result = await connection.execute(
        r'''
        SELECT user_uid, user_email, user_name, user_surname, user_phone, user_dob, user_created_at
        FROM users
        WHERE user_email = $1
        ''',
        parameters: [email.value],
      );
      
      if (result.isEmpty) return null;
      
      final userModel = UserModel.fromDatabaseRow(result.first);
      return userModel.toDomain();
    });
  }

  @override
  Future<bool> existsById(UserId userId) async {
    return _pool.withConnection((connection) async {
      final result = await connection.execute(
        r'''
        SELECT 1 FROM users WHERE user_uid = $1 LIMIT 1
        ''',
        parameters: [userId.value],
      );
      
      return result.isNotEmpty;
    });
  }

  @override
  Future<bool> existsByEmail(Email email) async {
    return _pool.withConnection((connection) async {
      final result = await connection.execute(
        r'''
        SELECT 1 FROM users WHERE user_email = $1 LIMIT 1
        ''',
        parameters: [email.value],
      );
      
      return result.isNotEmpty;
    });
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    await _pool.withConnection((connection) async { 
      final userModel = UserModel.fromDomain(user);
      
      await connection.execute(
        r'''
        INSERT INTO users (user_uid, user_email, user_name, user_surname, user_phone, user_dob, user_created_at)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        ''',
        parameters: [
          userModel.userUid,
          userModel.userEmail,
          userModel.userName,
          userModel.userSurname,
          userModel.userPhone,
          userModel.userDob,
          userModel.userCreatedAt ?? DateTime.now(),
        ],
      );
    });
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    await _pool.withConnection((connection) async {
      final userModel = UserModel.fromDomain(user);
      
      await connection.execute(
        r'''
        UPDATE users 
        SET user_email = $2, user_name = $3, user_surname = $4, 
            user_phone = $5, user_dob = $6
        WHERE user_uid = $1
        ''',
        parameters: [
          userModel.userUid,
          userModel.userEmail,
          userModel.userName,
          userModel.userSurname,
          userModel.userPhone,
          userModel.userDob,
        ],
      );
    });
  }

  @override
  Future<void> deleteUser(UserId userId) async {
    await _pool.withConnection((connection) async {
      await connection.execute(
        r'''
        DELETE FROM users WHERE user_uid = $1
        ''',
        parameters: [userId.value],
      );
    });
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    return _pool.withConnection((connection) async {
      final result = await connection.execute(
        '''
        SELECT user_uid, user_email, user_name, user_surname, user_phone, user_dob, user_created_at
        FROM users
        ORDER BY user_created_at DESC
        ''',
      );
      
      return result
          .map((row) => UserModel.fromDatabaseRow(row).toDomain())
          .toList();
    });
  }
}
