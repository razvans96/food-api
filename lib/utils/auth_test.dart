import 'package:dotenv/dotenv.dart';
import 'package:food_api/config/firebase_service_account.dart';
import 'package:logging/logging.dart';

class AuthTest {
  static final Logger _logger = Logger('AuthTest');

  static Future<Map<String, dynamic>> testAuthentication() async {
    final result = <String, dynamic>{
      'success': false,
      'message': '',
      'details': <String, dynamic>{},
    };

    try {
      final env = DotEnv()..load();
      final projectId = env['FIREBASE_PROJECT_ID'];
      final projectNumber = env['FIREBASE_PROJECT_NUMBER'];
      
      if (projectId == null) {
        result['message'] = 'FIREBASE_PROJECT_ID no está configurado';
        return result;
      }

      _logger..info('Iniciando test de autenticación...')
      ..info('Project ID: $projectId')
      ..info('Project Number: $projectNumber');

      final client = await getFirebaseAuthClient();
      _logger.info('[V] Cliente OAuth obtenido exitosamente');

      // Test 1: Firebase Management API
      final managementUrl = Uri.parse(
        'https://firebase.googleapis.com/v1beta1/projects/$projectId',
      );

      _logger.info('Probando Firebase Management API...');
      final managementResponse = await client.get(managementUrl);
      
      _logger..info('Management API response status: ${managementResponse.statusCode}')
      ..info('Management API response headers: ${managementResponse.headers}')
      ..info('Management API response body: ${managementResponse.body}');
      
      (result['details'] as Map<String, dynamic>)['management_api'] = {
        'status_code': managementResponse.statusCode,
        'success': managementResponse.statusCode == 200,
        'response_body': managementResponse.body,
        'headers': managementResponse.headers.toString(),
      };

      // Test 2: App Check API (si tienes app ID)
      final androidAppId = env['FIREBASE_ANDROID_APP_ID'];
      if (androidAppId != null && projectNumber != null) {
        _logger.info('Probando App Check API...');
        final appCheckUrl = Uri.parse(
          'https://firebaseappcheck.googleapis.com/v1beta/projects/$projectNumber/apps/$androidAppId:exchangeDebugToken',
        );
        
        
        final appCheckResponse = await client.get(appCheckUrl);
        (result['details'] as Map<String, dynamic>)['app_check_api'] = {
          'status_code': appCheckResponse.statusCode,
          'success': appCheckResponse.statusCode == 200 || appCheckResponse.statusCode == 404,
          'response_body': appCheckResponse.body,
        };
      }

      client.close();

      if (managementResponse.statusCode == 200) {
        result['success'] = true;
        result['message'] = '[V] Autenticación funcionando correctamente';
        _logger.info('[V] Todos los tests pasaron');
      } else {
        result['message'] = '[X] Problema de autenticación en Management API';
        _logger.warning('[X] Management API falló: ${managementResponse.statusCode}');
      }

    } catch (e, stackTrace) {
      result['message'] = '[X] Error en test: $e';
      (result['details'] as Map<String, dynamic>)['error'] = e.toString();
      (result['details'] as Map<String, dynamic>)['stack_trace'] = stackTrace.toString();
      _logger.severe('[X] Error en test de autenticación: $e\n$stackTrace');
    }

    return result;
  }
}
