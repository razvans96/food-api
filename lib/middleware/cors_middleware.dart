import 'package:dart_frog/dart_frog.dart';

Middleware corsMiddleware = (handler) {
  return (context) async {
    final response = await handler(context);

    return response.copyWith(
      headers: {
        ...response.headers,
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      },
    );
  };
};
