import 'dart:convert';

import 'package:food_api/infrastructure/config/app_config.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:logging/logging.dart';

final _scopes = [
  'https://www.googleapis.com/auth/cloud-platform',
  'https://www.googleapis.com/auth/firebase',
];

final _logger = Logger('FirebaseServiceAccount');

Future<AutoRefreshingAuthClient> getFirebaseAuthClient() async {
  Logger.root.level = Level.INFO;

  final serviceAccountJson = AppConfig.firebaseServiceAccount;
  if (serviceAccountJson == null) {
    throw Exception(
      'Firebase service account configuration is missing or invalid. '
      'Check FIREBASE_SA_BASE64 environment variable.',
    );
  }

  try {
    final credentials = ServiceAccountCredentials.fromJson(
      jsonDecode(serviceAccountJson),
    );

    return clientViaServiceAccount(credentials, _scopes);
  } catch (e, st) {
    _logger.severe('Error creating Firebase auth client: $e\n$st');
    rethrow;
  }
}
