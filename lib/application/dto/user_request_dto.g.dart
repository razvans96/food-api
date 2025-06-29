// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserRequestDto _$CreateUserRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateUserRequestDto(
      userUid: json['user_uid'] as String,
      userEmail: json['user_email'] as String,
      userName: json['user_name'] as String,
      userSurname: json['user_surname'] as String,
      userDob: DateTime.parse(json['user_dob'] as String),
      userPhone: json['user_phone'] as String?,
      userDietaryRestrictions:
          (json['user_dietary_restrictions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$CreateUserRequestDtoToJson(
        CreateUserRequestDto instance) =>
    <String, dynamic>{
      'user_uid': instance.userUid,
      'user_email': instance.userEmail,
      'user_name': instance.userName,
      'user_surname': instance.userSurname,
      'user_dob': instance.userDob.toIso8601String(),
      'user_phone': instance.userPhone,
      'user_dietary_restrictions': instance.userDietaryRestrictions,
    };

UpdateUserRequestDto _$UpdateUserRequestDtoFromJson(
        Map<String, dynamic> json) =>
    UpdateUserRequestDto(
      userName: json['user_name'] as String?,
      userSurname: json['user_surname'] as String?,
      userPhone: json['user_phone'] as String?,
      userDob: json['user_dob'] == null
          ? null
          : DateTime.parse(json['user_dob'] as String),
      userDietaryRestrictions:
          (json['user_dietary_restrictions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$UpdateUserRequestDtoToJson(
        UpdateUserRequestDto instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
      'user_surname': instance.userSurname,
      'user_phone': instance.userPhone,
      'user_dob': instance.userDob?.toIso8601String(),
      'user_dietary_restrictions': instance.userDietaryRestrictions,
    };
