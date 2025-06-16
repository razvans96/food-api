import 'package:food_api/domain/value_objects/email.dart';
import 'package:food_api/domain/value_objects/user_id.dart';
import 'package:meta/meta.dart';

@immutable
class UserEntity {
  final UserId id;
  final Email email;
  final String? name;
  final String? surname;
  final String? phone;
  final DateTime? dateOfBirth;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.createdAt, 
    this.name,
    this.surname,
    this.phone,
    this.dateOfBirth,
    this.updatedAt,
  });

  // Métodos de dominio (lógica de negocio)
  bool hasCompleteProfile() {
    return name != null && 
           surname != null && 
           phone != null && 
           dateOfBirth != null;
  }

  bool isAdult() {
    if (dateOfBirth == null) return false;
    final now = DateTime.now();
    final age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month || 
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      return age - 1 >= 18;
    }
    return age >= 18;
  }

  String get fullName => '${name ?? ''} ${surname ?? ''}'.trim();

  UserEntity touch() {
    return copyWith(updatedAt: DateTime.now());
  }
  
  // Método para crear una copia del objeto con algunos campos modificados para mantener immutabilidad
  UserEntity copyWith({
    UserId? id,
    Email? email,
    String? name,
    String? surname,
    String? phone,
    DateTime? dateOfBirth,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'UserEntity(id: $id, email: $email, name: $name)';
}
