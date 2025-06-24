import 'package:json_annotation/json_annotation.dart';

part 'user_request_dto.g.dart';

@JsonSerializable()
class CreateUserRequestDto {
  @JsonKey(name: 'user_uid')
  final String userUid;
  
  @JsonKey(name: 'user_email')
  final String userEmail;
  
  @JsonKey(name: 'user_name')
  final String userName;
  
  @JsonKey(name: 'user_surname')
  final String userSurname;
  
  @JsonKey(name: 'user_phone')
  final String? userPhone;
  
  @JsonKey(name: 'user_dob')
  final String? userDob;

  const CreateUserRequestDto({
    required this.userUid,
    required this.userEmail,
    required this.userName,
    required this.userSurname,
    this.userPhone,
    this.userDob,
  });

  factory CreateUserRequestDto.fromJson(Map<String, dynamic> json) => 
      _$CreateUserRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestDtoToJson(this);

  @override
  String toString() => 'CreateUserRequestDto(uid: $userUid, email: $userEmail)';
}

@JsonSerializable()
class UpdateUserRequestDto {
  @JsonKey(name: 'user_name')
  final String? userName;
  
  @JsonKey(name: 'user_surname')
  final String? userSurname;
  
  @JsonKey(name: 'user_phone')
  final String? userPhone;
  
  @JsonKey(name: 'user_dob')
  final String? userDob;

  const UpdateUserRequestDto({
    this.userName,
    this.userSurname,
    this.userPhone,
    this.userDob,
  });

  factory UpdateUserRequestDto.fromJson(Map<String, dynamic> json) => 
      _$UpdateUserRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestDtoToJson(this);

  @override
  String toString() => 'UpdateUserRequestDto(name: $userName, surname: $userSurname)';
}
