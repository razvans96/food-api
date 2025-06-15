import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/shared/middleware/cors_middleware.dart';
import 'package:food_api/shared/middleware/dependency_injection_middleware.dart';
import 'package:food_api/shared/utils/log_service.dart';
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
    .use(corsMiddleware)
    .use(dependencyInjectionMiddleware);
}
