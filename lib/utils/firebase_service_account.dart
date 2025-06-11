import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:logging/logging.dart';

final _scopes = [
  'https://www.googleapis.com/auth/cloud-platform',
  'https://www.googleapis.com/auth/firebase',
];
final env = DotEnv()..load();
final _logger = Logger('FirebaseServiceAccount');

Future<AutoRefreshingAuthClient> getFirebaseAuthClient() async {
  Logger.root.level = Level.INFO;

  final raw = env['FIREBASE_SA_BASE64'];
  if (raw == null) {
    throw Exception(
        'Required environment variable FIREBASE_SA_BASE64 is not set.',);
  }
  try {
    final jsonString = utf8.decode(base64Decode(raw));
    final credentials =
        ServiceAccountCredentials.fromJson(jsonDecode(jsonString));

    return clientViaServiceAccount(credentials, _scopes);
  } catch (e, st) {
    _logger.severe('Error decoding service account: $e\n$st');
    rethrow;
  }
}
