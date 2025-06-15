import 'package:food_api/domain/entities/user_entity.dart';
import 'package:food_api/domain/value_objects/email.dart';
import 'package:food_api/domain/value_objects/user_id.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_model.g.dart';

@immutable
@JsonSerializable()
class UserModel {
  @JsonKey(name: 'user_uid')
  final String userUid;
  
  @JsonKey(name: 'user_email')
  final String userEmail;
  
  @JsonKey(name: 'user_name')
  final String? userName;
  
  @JsonKey(name: 'user_surname')
  final String? userSurname;
  
  @JsonKey(name: 'user_phone')
  final String? userPhone;
  
  @JsonKey(name: 'user_dob')
  final String? userDob;
  
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  const UserModel({
    required this.userUid,
    required this.userEmail,
    this.userName,
    this.userSurname,
    this.userPhone,
    this.userDob,
    this.createdAt,
  });

  
  factory UserModel.fromJson(Map<String, dynamic> json) => 
      _$UserModelFromJson(json);

  // Conversión a JSON (para responses HTTP)
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // Conversión desde Database Row
  factory UserModel.fromDatabaseRow(List<dynamic> row) {
    return UserModel(
      userUid: row[0] as String,
      userEmail: row[1] as String,
      userName: row[2] as String?,
      userSurname: row[3] as String?,
      userPhone: row[4] as String?,
      userDob: row[5] as String?,
      createdAt: row.length > 6 ? row[6] as DateTime? : null,
    );
  }

  // Conversión hacia Domain Entity
  UserEntity toDomain() {
    return UserEntity(
      id: UserId(userUid),
      email: Email(userEmail),
      name: userName,
      surname: userSurname,
      phone: userPhone,
      dateOfBirth: userDob != null ? DateTime.tryParse(userDob!) : null,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  // Conversión desde Domain Entity
  factory UserModel.fromDomain(UserEntity entity) {
    return UserModel(
      userUid: entity.id.value,
      userEmail: entity.email.value,
      userName: entity.name,
      userSurname: entity.surname,
      userPhone: entity.phone,
      userDob: entity.dateOfBirth?.toIso8601String(),
      createdAt: entity.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          userUid == other.userUid;

  @override
  int get hashCode => userUid.hashCode;

  @override
  String toString() => 'UserModel(uid: $userUid, email: $userEmail)';
}
