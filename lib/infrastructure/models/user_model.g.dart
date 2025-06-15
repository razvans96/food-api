// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userUid: json['user_uid'] as String,
      userEmail: json['user_email'] as String,
      userName: json['user_name'] as String?,
      userSurname: json['user_surname'] as String?,
      userPhone: json['user_phone'] as String?,
      userDob: json['user_dob'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_uid': instance.userUid,
      'user_email': instance.userEmail,
      'user_name': instance.userName,
      'user_surname': instance.userSurname,
      'user_phone': instance.userPhone,
      'user_dob': instance.userDob,
      'created_at': instance.createdAt?.toIso8601String(),
    };
