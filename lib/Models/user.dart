import 'package:json_annotation/json_annotation.dart';

part 'Auth_User.g.dart';

@JsonSerializable()
class UserModel {
  final String? username;
  final String email;
  final String? fullName;
  final String? refreshToken;
  final String? accessToken;
  final String password;

  UserModel({
    this.username,
    required this.email,
    this.fullName,
    this.refreshToken,
    this.accessToken,
    required this.password,
  });

  /// Factory constructor for creating a new `UserModel` instance from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Method to convert `UserModel` instance to a JSON map.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
