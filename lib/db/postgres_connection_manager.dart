import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';

class PostgresConnectionManager {
  static Connection? _connection;

  static Future<Connection> getConnection() async {
    if (_connection != null && _connection!.isOpen) {
      return _connection!;
    }
    final env = DotEnv()..load();
    _connection = await Connection.open(
      Endpoint(
        host: env['DB_HOST'] ?? 'localhost',
        port: int.tryParse(env['DB_PORT'] ?? '5432') ?? 5432,
        database: env['DB_NAME'] ?? 'my_database',
        username: env['DB_USER'] ?? 'user',
        password: env['DB_PASSWORD'] ?? 'password',
      ),
    );
    return _connection!;
  }

  static Future<void> closeConnection() async {
    if (_connection != null && _connection!.isOpen) {
      await _connection!.close();
    }
  }
}
