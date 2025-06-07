import 'package:dart_frog/dart_frog.dart';
import 'package:logging/logging.dart';

final _logger = Logger('HeadersLogger');

Handler logHeadersMiddleware(Handler handler) {
  return (context) async {
    print('logHeadersMiddleware ejecutado');
    final headers = context.request.headers;
    final logLine =
        '[${DateTime.now().toIso8601String()}] ${headers.entries.map((e) => '${e.key}: ${e.value}').join(', ')}';
    _logger.info(logLine);
    return handler(context);
  };
}
