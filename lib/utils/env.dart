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
  final value = Platform.environment[key];
  if (value == null || value.trim().isEmpty) {
    if (fallback != null) return fallback;
    throw Exception('ENV variable "$key" is not defined');
  }

  try {
    return int.parse(value);
  } catch (_) {
    if (fallback != null) return fallback;
    throw Exception('ENV variable "$key" is not a valid integer');
  }
}
