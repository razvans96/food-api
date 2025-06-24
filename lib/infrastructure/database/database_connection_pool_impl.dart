import 'dart:async';

import 'package:food_api/domain/interfaces/database_connection_pool.dart';
import 'package:food_api/infrastructure/config/app_config.dart';
import 'package:postgres/postgres.dart';

class DatabaseConnectionPoolImpl implements IDatabaseConnectionPool {
  Pool<Connection>? _pool;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _pool = Pool.withEndpoints(
        [
          Endpoint(
            host: AppConfig.dbHost,
            port: AppConfig.dbPort,
            database: AppConfig.dbName,
            username: AppConfig.dbUser,
            password: AppConfig.dbPassword,
          ),
        ],
        settings: PoolSettings(
          maxConnectionCount: AppConfig.dbPoolMaxConnections,
          maxConnectionAge: AppConfig.dbPoolIdleTimeout,
          connectTimeout: AppConfig.dbPoolConnectionTimeout,
          queryTimeout: AppConfig.dbPoolConnectionTimeout,
          sslMode: SslMode.disable,
          applicationName: 'food-api',
        ),
      );

      _finalizer.attach(this, _pool);
      
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize database connection pool: $e');
    }
  }

  @override
  Future<T> withConnection<T>(
    Future<T> Function(Connection connection) operation,
  ) async {
    await _ensureInitialized();

    try {
      return await _pool!.withConnection(operation);
    } catch (e) {
      throw Exception('Database operation failed: $e');
    }
  }

  @override
  Future<T> withTransaction<T>(
    Future<T> Function(TxSession session) operation,
  ) async {
    await _ensureInitialized();

    try {
      return _pool!.withConnection((connection) async {
        return connection.runTx(operation);
      });
    } catch (e) {
      throw Exception('Database transaction failed: $e');
    }
  }

  @override
  Future<void> close() async {
    if (_pool != null) {
      await _pool!.close();
      _pool = null;
      _isInitialized = false;
    }
  }

  static final _finalizer = Finalizer<Pool<Connection>?>((pool) {
    pool?.close().ignore();
  });

  @override
  bool get isOpen => _isInitialized && _pool != null;

  @override
  Map<String, dynamic> get stats {
    if (_pool == null) {
      return {'status': 'not_initialized'};
    }

    return {
      'status': 'active',
      'max_connections': AppConfig.dbPoolMaxConnections,
      'min_connections': AppConfig.dbPoolMinConnections,
      'connection_timeout': AppConfig.dbPoolConnectionTimeout.inSeconds,
      'idle_timeout': AppConfig.dbPoolIdleTimeout.inMinutes,
    };
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }
}
