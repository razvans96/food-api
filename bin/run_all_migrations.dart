import 'dart:io';
import 'package:food_api/db/postgres_connection_manager.dart';
import 'package:logging/logging.dart';

final _logger = Logger('MigrationAll');

Future<void> main() async {
  Logger.root.level = Level.INFO;
  final logDir = Directory('logs');
  if (!logDir.existsSync()) {
    logDir.createSync(recursive: true);
  }
  final logFile = File('logs/migration_all.log');
  Logger.root.onRecord.listen((record) {
    final logLine = '${record.level.name}: ${record.time}: ${record.message}\n';
    logFile.writeAsStringSync(logLine, mode: FileMode.append);
  });

  final migrationsDir = Directory('migrations');
  if (!migrationsDir.existsSync()) {
    _logger.severe('La carpeta migrations no existe.');
    exit(1);
  }

  final migrationFiles = migrationsDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.sql'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  if (migrationFiles.isEmpty) {
    _logger.warning('No se encontraron archivos de migración.');
    exit(0);
  }

  final conn = await PostgresConnectionManager.getConnection();

  for (final file in migrationFiles) {
    final fileName = file.uri.pathSegments.last;
    _logger.info('Ejecutando migración: $fileName');
    final sql = await file.readAsString();
    final statements = sql.split(';')
    .map((s) => s.trim())
    .where((s) => s.isNotEmpty && !s.startsWith('--'));

    for (final statement in statements) {
      await conn.execute(statement);
    }
    _logger.info('Migración $fileName completada.');
  }

  await PostgresConnectionManager.closeConnection();
  _logger.info('Todas las migraciones han sido ejecutadas.');
}
