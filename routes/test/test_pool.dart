import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/domain/interfaces/database_connection_pool.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final pool = context.read<IDatabaseConnectionPool>();
    
    final stats = pool.stats;
    
    return Response.json(
      body: {
        'message': 'Pool connection test successful',
        'pool_stats': stats,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {
        'error': 'Pool test failed: $e',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}
