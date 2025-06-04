import 'dart:io';
import 'package:food_api/db/postgres_connection_manager.dart';
import 'package:logging/logging.dart';


final _logger = Logger('Migration');
Future<void> main(List<String> args) async {
  Logger.root.level = Level.INFO;
  final logDir = Directory('logs');
  if (!logDir.existsSync()) {
    logDir.createSync(recursive: true);
  }
  final logFile = File('logs/migration.log');
  Logger.root.onRecord.listen((record) {
    final logLine = '${record.level.name}: ${record.time}: ${record.message}\n';
    logFile.writeAsStringSync(logLine, mode: FileMode.append);
  });

  if (args.isEmpty) {
    _logger.severe('Por favor, indica el nombre del archivo de migración a ejecutar.');
    exit(1);
  }

  final migrationFile = args[0];
  final file = File('migrations/$migrationFile');
  if (!file.existsSync()) {
    _logger.severe('El archivo migrations/$migrationFile no existe.');
    exit(1);
  }
  final sql = await file.readAsString();

  final conn = await PostgresConnectionManager.getConnection();

  _logger.info('Ejecutando migración: migrations/$migrationFile');  
  await conn.execute(sql);

  _logger.info('Migración completada.');
  await PostgresConnectionManager.closeConnection();
}
