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
    final projectId = env['FIREBASE_PROJECT_ID'];
    String? appId;

    if (platform == 'android') {
      appId = env['FIREBASE_ANDROID_APP_ID'];
    } else if (platform == 'web') {
      appId = env['FIREBASE_WEB_APP_ID'];
    } else {
      _logger.warning('Plataforma no soportada: $platform');
      return _unauthorized('Plataforma no soportada');
    }

    if (projectId == null || appId == null) {
      _logger.severe('Faltan variables de entorno para $platform');
      return _unauthorized('Configuración incompleta');
    }

    final client = await getFirebaseAuthClient();

    final url = Uri.parse(
      'https://firebaseappcheck.googleapis.com/v1/projects/$projectId/apps/$appId:exchangeDebugToken',
    );

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
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
