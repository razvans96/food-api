import 'package:food_api/domain/value_objects/email.dart';
import 'package:food_api/domain/value_objects/user_id.dart';
import 'package:meta/meta.dart';

@immutable
class UserEntity {
  final UserId id;
  final Email email;
  final String name;
  final String surname;
  final DateTime dateOfBirth;
  final String? phone;
  final List<String>? dietaryRestrictions;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.dateOfBirth,
    this.phone,
    this.dietaryRestrictions,
    this.createdAt,
    this.updatedAt,
  });

  int get profileCompletenessPercentage {
    
    var percentage = 60;
    
    if (phone != null) percentage += 20;
    if (dietaryRestrictions != null) {
      percentage += 20;
    }
    
    return percentage;
  }

  bool get isAdult {
    final now = DateTime.now();
    final age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month || 
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      return age - 1 >= 18;
    }
    return age >= 18;
  }

  String get fullName => '$name $surname'.trim();
  
  UserEntity copyWith({
    UserId? id,
    Email? email,
    String? name,
    String? surname,
    String? phone,
    DateTime? dateOfBirth,
    List<String>? dietaryRestrictions,
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
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
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
