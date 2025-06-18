import 'dart:convert';
import 'package:food_api/infrastructure/config/app_config.dart';
import 'package:food_api/shared/utils/firebase_service_account.dart';
import 'package:logging/logging.dart';

class AppCheckService {
  final String platform;
  static final Logger _logger = Logger('AppCheckValidator');

  AppCheckService({required this.platform});

  Future<bool> isValid(String token) async {
    Logger.root.level = Level.INFO;

    final projectNumber = AppConfig.firebaseProjectNumber;
    String? appId;

    if (platform == 'android') {
      appId = AppConfig.firebaseAndroidAppId;
    } else if (platform == 'web') {
      appId = AppConfig.firebaseWebAppId;
    } else {
      return _unauthorized('Plataforma no soportada: $platform');
    }

    final client = await getFirebaseAuthClient();

    final url = Uri.parse(
      'https://firebaseappcheck.googleapis.com/v1/projects/$projectNumber/apps/$appId:exchangeDebugToken',
    );

    final response = await client.post(
      url,
      body: jsonEncode({'debugToken': token, 'limitedUse': true}),
    );

    _logger.info(
      'Plataforma: $platform, Status: ${response.statusCode}, Body: ${response.body}',
    );

    client.close();
    return response.statusCode == 200;
  }

  bool _unauthorized(String reason) {
    _logger.warning('401 Unauthorized: $reason');
    return false;
  }
}
