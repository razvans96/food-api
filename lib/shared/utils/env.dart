import 'dart:io';
import 'package:dotenv/dotenv.dart' as dotenv;

final _dotenv = dotenv.DotEnv()..load();

String getEnv(String key, {String? fallback}) {
  
  final systemValue = Platform.environment[key];
  if (systemValue != null) return systemValue;

  final localValue = _dotenv[key];
  if (localValue != null) return localValue;

  if (fallback != null) return fallback;

  throw Exception('ENV variable "$key" not found.');
}

int getEnvInt(String key, {int? fallback}) {
  final systemValue = Platform.environment[key];
  if (systemValue != null && systemValue.trim().isNotEmpty) {
    try {
      return int.parse(systemValue);
    } catch (_) {
      throw Exception('ENV variable "$key" is not a valid integer');
    }
  }

  final localValue = _dotenv[key];
  if (localValue != null && localValue.trim().isNotEmpty) {
    try {
      return int.parse(localValue);
    } catch (_) {
      throw Exception('ENV variable "$key" is not a valid integer');
    }
  }

  if (fallback != null) return fallback;

  throw Exception('ENV variable "$key" is not defined');
}
