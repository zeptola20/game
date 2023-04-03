// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRequestModel _$TokenRequestModelFromJson(Map<String, dynamic> json) =>
    TokenRequestModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$TokenRequestModelToJson(TokenRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
