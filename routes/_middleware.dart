import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/middleware/app_check_middleware.dart';
import 'package:food_api/middleware/cors_middleware.dart';
import 'package:food_api/middleware/log_headers_middleware.dart';
import 'package:logging/logging.dart';

void _setupLogging() {
  Logger.root.level = Level.INFO;
  final logDir = Directory('logs');
  if (!logDir.existsSync()) {
    logDir.createSync(recursive: true);
  }
  Logger.root.onRecord.listen((record) {
    String fileName;
    if (record.loggerName == 'FirebaseServiceAccount') {
      fileName = 'logs/firebase_service_account.log';
    } else if (record.loggerName == 'AppCheckValidator') {
      fileName = 'logs/app_check.log';
    } else if (record.loggerName == 'HeadersLogger') {
      fileName = 'logs/headers.log';
    } else {
      fileName = 'logs/general.log';
    }
    final logFile = File(fileName);
    final logLine =
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}\n';
    logFile.writeAsStringSync(logLine, mode: FileMode.append);
  });
}

Handler middleware(Handler handler) {
  _setupLogging();
  return handler
      .use(appCheckMiddleware)
      .use(logHeadersMiddleware)
      .use(corsMiddleware);

}
