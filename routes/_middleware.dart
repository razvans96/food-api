import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/middleware/cors_middleware.dart';
import 'package:food_api/services/log_service.dart';
import 'package:logging/logging.dart';

final _logService = LogService();

void _setupLogging() {
  Logger.root.onRecord.listen((record) async {
    await _logService.insertLog(
      level: record.level.name,
      loggerName: record.loggerName,
      message: record.message,
    );
  });
}

Handler middleware(Handler handler) {
  _setupLogging();
  return handler
    .use(corsMiddleware);
}
