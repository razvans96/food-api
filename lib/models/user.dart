import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String userUid;
  final String userEmail;
  final String? userName;
  final String? userSurname;
  final String? userPhone;
  final String? userDob;

  User({
    required this.userUid,
    required this.userEmail,
    this.userName,
    this.userSurname,
    this.userPhone,
    this.userDob,
  });

factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
  
}
