import 'package:food_api/domain/failures/domain_failures.dart';
import 'package:meta/meta.dart';


@immutable
class Email {

  factory Email(String email) {
    if (email.isEmpty) {
      throw const InvalidEmailFailure('Email no puede estar vacío');
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      throw const InvalidEmailFailure('Formato de email inválido');
    }
    
    return Email._(email.toLowerCase().trim());
  }
  final String value;

  const Email._(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Email && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
