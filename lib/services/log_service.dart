import 'package:food_api/repositories/log_repository.dart';

class LogService {
  
  final LogRepository _logRepository = LogRepository();

  Future<void> insertLog({
    required String level,
    required String loggerName,
    required String message,
  }) async {
    await _logRepository.insertLog(
      level: level,
      loggerName: loggerName,
      message: message,
    );
  }
}
