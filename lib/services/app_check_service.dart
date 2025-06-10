import 'dart:convert';
import 'package:dotenv/dotenv.dart';
import 'package:food_api/config/firebase_service_account.dart';
import 'package:logging/logging.dart';

class AppCheckService {
  final String platform;
  static final Logger _logger = Logger('AppCheckValidator');

  AppCheckService({required this.platform});

  Future<bool> isValid(String token) async {
    Logger.root.level = Level.INFO;

    final env = DotEnv()..load();
    final projectNumber = env['FIREBASE_PROJECT_NUMBER'];
    String? appId;

    if (platform == 'android') {
      appId = env['FIREBASE_ANDROID_APP_ID'];
    } else if (platform == 'web') {
      appId = env['FIREBASE_WEB_APP_ID'];
    } else {
      return _unauthorized('Plataforma no soportada: $platform');
    }

    if (projectNumber == null || appId == null) {
      return _unauthorized('Faltan variables de entorno para $platform');
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
        'Plataforma: $platform, Status: ${response.statusCode}, Body: ${response.body}',);

    client.close();
    return response.statusCode == 200;
  }

  bool _unauthorized(String reason) {
    _logger.warning('401 Unauthorized: $reason');
    return false;
  }
}
