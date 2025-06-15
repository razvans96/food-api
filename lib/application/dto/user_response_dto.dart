import 'package:food_api/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response_dto.g.dart';

@JsonSerializable()
class UserResponseDto {
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
  final DateTime createdAt;
  
  @JsonKey(name: 'has_complete_profile')
  final bool hasCompleteProfile;
  
  @JsonKey(name: 'full_name')
  final String fullName;

  const UserResponseDto({
    required this.userUid,
    required this.userEmail,
    required this.createdAt, 
    required this.hasCompleteProfile, 
    required this.fullName, 
    this.userName,
    this.userSurname,
    this.userPhone,
    this.userDob,
  });

  // Conversión desde Domain Entity
  factory UserResponseDto.fromDomain(UserEntity entity) {
    return UserResponseDto(
      userUid: entity.id.value,
      userEmail: entity.email.value,
      userName: entity.name,
      userSurname: entity.surname,
      userPhone: entity.phone,
      userDob: entity.dateOfBirth?.toIso8601String(),
      createdAt: entity.createdAt,
      hasCompleteProfile: entity.hasCompleteProfile(),
      fullName: entity.fullName,
    );
  }

  factory UserResponseDto.fromJson(Map<String, dynamic> json) => 
      _$UserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseDtoToJson(this);

  @override
  String toString() => 'UserResponseDto(uid: $userUid, email: $userEmail)';
}
