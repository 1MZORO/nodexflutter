// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] as String?,
      email: json['email'] as String,
      fullname: json['fullname'] as String?,
      refreshToken: json['refreshToken'] as String?,
      accessToken: json['accessToken'] as String?,
      password: json['password'] as String,
      otp: json['otp'] as String,
      newPassword: json['newPassword'] as String,
      confirmPassword: json['confirmPassword'] as String
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'fullname': instance.fullname,
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
      'password': instance.password,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword
    };
