import 'package:food_api/config/app_config.dart';
import 'package:postgres/postgres.dart';

class PostgresConnectionManager {
  static Connection? _connection;

  static Future<Connection> getConnection() async {
    if (_connection != null && _connection!.isOpen) {
      return _connection!;
    }
    _connection = await Connection.open(
      Endpoint(
        host: AppConfig.dbHost,
        port: AppConfig.dbPort,
        database: AppConfig.dbName,
        username: AppConfig.dbUser,
        password: AppConfig.dbPassword,
      ),
    );
    if (_connection == null) {
      throw Exception('Failed to connect to the database');
    }
    return _connection!;
  }

  static Future<void> closeConnection() async {
    if (_connection != null && _connection!.isOpen) {
      await _connection!.close();
    }
  }
}
