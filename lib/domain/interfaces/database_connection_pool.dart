import 'package:postgres/postgres.dart';

abstract class IDatabaseConnectionPool {

  Future<T> withConnection<T>(
    Future<T> Function(Connection connection) operation,
  );
  
  Future<T> withTransaction<T>(
    Future<T> Function(TxSession session) operation,
  );
  
  Future<void> close();
  
  bool get isOpen;
  
  Map<String, dynamic> get stats;
}
