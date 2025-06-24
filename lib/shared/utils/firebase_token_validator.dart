import 'dart:convert';

import 'package:food_api/infrastructure/config/app_config.dart';
import 'package:food_api/shared/utils/firebase_service_account.dart';


class FirebaseTokenValidator {

  static Future<Map<String, dynamic>?> validateToken(String idToken) async {
    final projectId = AppConfig.firebaseProjectId;
    
    try {
      final client = await getFirebaseAuthClient();
      
      final response = await client.post(
        Uri.parse('https://identitytoolkit.googleapis.com/v1/projects/$projectId/accounts:lookup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final users = data['users'] as List<dynamic>?;
        
        if (users != null && users.isNotEmpty) {
          final user = users.first as Map<String, dynamic>;
          print('Token válido para UID: ${user['localId']}');
          return user;
        }
      }
      
      print('Token inválido');
      return null;
      
    } catch (e) {
      print('Error validando token: $e');
      return null;
    }
  }
}
