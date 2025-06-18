import 'dart:convert';

import 'package:food_api/shared/utils/env.dart';

class AppConfig {
  static final firebaseProjectId = getEnv('FIREBASE_PROJECT_ID');
  static final firebaseProjectNumber = getEnv('FIREBASE_PROJECT_NUMBER');
  static final firebaseAndroidAppId = getEnv('FIREBASE_ANDROID_APP_ID');
  static final firebaseWebAppId = getEnv('FIREBASE_WEB_APP_ID');
  static final firebaseServiceAccountBase64 = getEnv('FIREBASE_SA_BASE64');
  static final firebaseServiceAccount =
      tryDecodeBase64(firebaseServiceAccountBase64);
  static final dbHost = getEnv('DB_HOST');
  static final dbPort = getEnvInt('DB_PORT');
  static final dbName = getEnv('DB_NAME');
  static final dbUser = getEnv('DB_USER');
  static final dbPassword = getEnv('DB_PASSWORD');
  
  static String? tryDecodeBase64(String? encoded) {
    if (encoded == null || encoded.trim().isEmpty) return null;
    try {
      return utf8.decode(base64Decode(encoded));
    } catch (_) {
      return null;
    }
  }
}
