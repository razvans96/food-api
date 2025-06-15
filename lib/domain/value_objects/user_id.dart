import 'package:food_api/domain/failures/domain_failures.dart';
import 'package:meta/meta.dart';

@immutable
class UserId {

  factory UserId(String id) {
    if (id.isEmpty) {
      throw const InvalidUserIdFailure('User ID no puede estar vacío');
    }
    
    if (id.length < 3) {
      throw const InvalidUserIdFailure('User ID debe tener al menos 3 caracteres');
    }
    
    return UserId._(id.trim());
  }
  final String value;

  const UserId._(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserId && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
