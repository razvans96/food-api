// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseDto _$UserResponseDtoFromJson(Map<String, dynamic> json) =>
    UserResponseDto(
      userUid: json['user_uid'] as String,
      userEmail: json['user_email'] as String,
      fullName: json['full_name'] as String,
      userName: json['user_name'] as String,
      userSurname: json['user_surname'] as String,
      userDob: DateTime.parse(json['user_dob'] as String),
      isAdult: json['user_is_adult'] as bool,
      profileCompletenessPercentage:
          (json['user_profile_completeness_percentage'] as num).toInt(),
      userPhone: json['user_phone'] as String?,
      userDietaryRestrictions:
          (json['user_dietary_restrictions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      createdAt: json['user_created_at'] == null
          ? null
          : DateTime.parse(json['user_created_at'] as String),
      updatedAt: json['user_updated_at'] == null
          ? null
          : DateTime.parse(json['user_updated_at'] as String),
    );

Map<String, dynamic> _$UserResponseDtoToJson(UserResponseDto instance) =>
    <String, dynamic>{
      'user_uid': instance.userUid,
      'user_email': instance.userEmail,
      'full_name': instance.fullName,
      'user_name': instance.userName,
      'user_surname': instance.userSurname,
      'user_dob': instance.userDob.toIso8601String(),
      'user_profile_completeness_percentage':
          instance.profileCompletenessPercentage,
      'user_is_adult': instance.isAdult,
      'user_phone': instance.userPhone,
      'user_dietary_restrictions': instance.userDietaryRestrictions,
      'user_created_at': instance.createdAt?.toIso8601String(),
      'user_updated_at': instance.updatedAt?.toIso8601String(),
    };
