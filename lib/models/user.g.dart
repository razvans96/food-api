// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userUid: json['userUid'] as String,
      userEmail: json['userEmail'] as String,
      userName: json['userName'] as String?,
      userSurname: json['userSurname'] as String?,
      userPhone: json['userPhone'] as String?,
      userDob: json['userDob'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userUid': instance.userUid,
      'userEmail': instance.userEmail,
      'userName': instance.userName,
      'userSurname': instance.userSurname,
      'userPhone': instance.userPhone,
      'userDob': instance.userDob,
    };
