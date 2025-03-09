import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

// cmd flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class UserModel {
  final String? username;
  final String email;
  final String? fullname;
  final String? refreshToken;
  final String? accessToken;
  final String? password;
  final String? otp;
  final String? newPassword;
  final String? confirmPassword;

  UserModel({
    this.username,
    required this.email,
    this.fullname,
    this.refreshToken,
    this.accessToken,
    this.password,
    this.otp,
    this.newPassword,
    this.confirmPassword
  });

  /// Factory constructor for creating a new `UserModel` instance from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Method to convert `UserModel` instance to a JSON map.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
