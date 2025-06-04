import 'package:food_api/db/postgres_connection_manager.dart';
import 'package:food_api/models/user.dart';

class UserRepository {
  Future<void> insertUser(User user) async {
    final conn = await PostgresConnectionManager.getConnection();
    await conn.execute(
      r'''
      INSERT INTO users (user_uid, user_email, user_name, user_surname, user_phone, user_dob)
      VALUES ($1, $2, $3, $4, $5, $6)
      ''',
      parameters: [
        user.userUid,
        user.userEmail,
        user.userName,
        user.userSurname,
        user.userPhone,
        user.userDob,
      ],
    );
    await PostgresConnectionManager.closeConnection();
  }
}
