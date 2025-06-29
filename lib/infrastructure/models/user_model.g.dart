// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userUid: json['user_uid'] as String,
      userEmail: json['user_email'] as String,
      userName: json['user_name'] as String,
      userSurname: json['user_surname'] as String,
      userDob: DateTime.parse(json['user_dob'] as String),
      userPhone: json['user_phone'] as String?,
      userDietaryRestrictions: json['user_dietary_restrictions'] as String?,
      userCreatedAt: json['user_created_at'] == null
          ? null
          : DateTime.parse(json['user_created_at'] as String),
      userUpdatedAt: json['user_updated_at'] == null
          ? null
          : DateTime.parse(json['user_updated_at'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_uid': instance.userUid,
      'user_email': instance.userEmail,
      'user_name': instance.userName,
      'user_surname': instance.userSurname,
      'user_dob': instance.userDob.toIso8601String(),
      'user_phone': instance.userPhone,
      'user_dietary_restrictions': instance.userDietaryRestrictions,
      'user_created_at': instance.userCreatedAt?.toIso8601String(),
      'user_updated_at': instance.userUpdatedAt?.toIso8601String(),
    };
