import 'dart:convert';

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
  final String userName;
  
  @JsonKey(name: 'user_surname')
  final String userSurname;
  
  @JsonKey(name: 'user_dob')
  final DateTime userDob;

  @JsonKey(name: 'user_phone')
  final String? userPhone;

  @JsonKey(name: 'user_dietary_restrictions')
  final String? userDietaryRestrictions;
  
  @JsonKey(name: 'user_created_at')
  final DateTime? userCreatedAt;

  @JsonKey(name: 'user_updated_at')
  final DateTime? userUpdatedAt;

  const UserModel({
    required this.userUid,
    required this.userEmail,
    required this.userName,
    required this.userSurname,
    required this.userDob, 
    this.userPhone,
    this.userDietaryRestrictions,
    this.userCreatedAt,
    this.userUpdatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => 
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);


  factory UserModel.fromDomain(UserEntity entity) {
    return UserModel(
      userUid: entity.id.value,
      userEmail: entity.email.value,
      userName: entity.name,
      userSurname: entity.surname,
      userPhone: entity.phone,
      userDob: entity.dateOfBirth,
      userDietaryRestrictions: entity.dietaryRestrictions != null 
          ? json.encode(entity.dietaryRestrictions) 
          : null,
      userCreatedAt: entity.createdAt,
      userUpdatedAt: entity.updatedAt,
    );
  }

  factory UserModel.fromPostgres(Map<String, dynamic> row) {
    return UserModel(
      userUid: row['user_uid'] as String,
      userEmail: row['user_email'] as String,
      userName: row['user_name'] as String,
      userSurname: row['user_surname'] as String,
      userPhone: row['user_phone'] as String?,
      userDob: row['user_dob'] as DateTime,
      userDietaryRestrictions: _deserializeJsonbField(row['user_dietary_restrictions']),
      userCreatedAt: row['user_created_at'] as DateTime?,
      userUpdatedAt: row['user_modified_at'] as DateTime?,
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      id: UserId(userUid),
      email: Email(userEmail),
      name: userName,
      surname: userSurname,
      phone: userPhone,
      dateOfBirth: userDob,
      dietaryRestrictions: _deserializeStringList(userDietaryRestrictions),
      createdAt: userCreatedAt,
      updatedAt: userUpdatedAt,
    );
  }


  List<String>? _deserializeStringList(String? jsonString) {
    if (jsonString?.isNotEmpty != true) return null;
    
    try {
      final decoded = json.decode(jsonString!);
    
      if (decoded is List) {
        return decoded
            .where((item) => item != null)
            .map((item) => item.toString())
            .toList();
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
  
  static String? _deserializeJsonbField(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is Map || value is List) return json.encode(value);
    return value.toString();
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
