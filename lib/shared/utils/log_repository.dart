import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';

class LogRepository {
  Future<void> insertLog({
    required String level,
    required String loggerName,
    required String message,
  }) async {
    final env = DotEnv()..load();
    final conn = await Connection.open(
      Endpoint(
        host: env['DB_HOST'] ?? 'localhost',
        port: int.tryParse(env['DB_PORT'] ?? '5432') ?? 5432,
        database: env['DB_NAME'] ?? 'my_database',
        username: env['DB_USER'] ?? 'user',
        password: env['DB_PASSWORD'] ?? 'password',
      ),
    );
    await conn.execute(
      r'''INSERT INTO log (log_level, log_logger_name, log_message) VALUES ($1, $2, $3)''',
      parameters: [
        level,
        loggerName,
        message,
      ],
    );
    await conn.close();
  }
}
