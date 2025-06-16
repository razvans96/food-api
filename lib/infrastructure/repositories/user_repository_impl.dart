import 'package:food_api/domain/entities/user_entity.dart';
import 'package:food_api/domain/repositories/user_repository.dart';
import 'package:food_api/domain/value_objects/email.dart';
import 'package:food_api/domain/value_objects/user_id.dart';
import 'package:food_api/infrastructure/database/postgres_connection_manager.dart';
import 'package:food_api/infrastructure/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  
  @override
  Future<UserEntity?> getUserById(UserId userId) async {
    final conn = await PostgresConnectionManager.getConnection();
    
    try {
      final result = await conn.execute(
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
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

  @override
  Future<UserEntity?> getUserByEmail(Email email) async {
    final conn = await PostgresConnectionManager.getConnection();
    
    try {
      final result = await conn.execute(
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
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

  @override
  Future<bool> existsById(UserId userId) async {
    final conn = await PostgresConnectionManager.getConnection();
    
    try {
      final result = await conn.execute(
        r'''
        SELECT 1 FROM users WHERE user_uid = $1 LIMIT 1
        ''',
        parameters: [userId.value],
      );
      
      return result.isNotEmpty;
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

  @override
  Future<bool> existsByEmail(Email email) async {
    final conn = await PostgresConnectionManager.getConnection();
    
    try {
      final result = await conn.execute(
        r'''
        SELECT 1 FROM users WHERE user_email = $1 LIMIT 1
        ''',
        parameters: [email.value],
      );
      
      return result.isNotEmpty;
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    final conn = await PostgresConnectionManager.getConnection();
    final userModel = UserModel.fromDomain(user);
    
    try {
      await conn.execute(
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
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final conn = await PostgresConnectionManager.getConnection();
    final userModel = UserModel.fromDomain(user);
    
    try {
      await conn.execute(
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
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

  @override
  Future<void> deleteUser(UserId userId) async {
    final conn = await PostgresConnectionManager.getConnection();
    
    try {
      await conn.execute(
        r'''
        DELETE FROM users WHERE user_uid = $1
        ''',
        parameters: [userId.value],
      );
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final conn = await PostgresConnectionManager.getConnection();
    
    try {
      final result = await conn.execute(
        '''
        SELECT user_uid, user_email, user_name, user_surname, user_phone, user_dob, user_created_at
        FROM users
        ORDER BY created_at DESC
        ''',
      );
      
      return result
          .map((row) => UserModel.fromDatabaseRow(row).toDomain())
          .toList();
    } finally {
      await PostgresConnectionManager.closeConnection();
    }
  }
}
