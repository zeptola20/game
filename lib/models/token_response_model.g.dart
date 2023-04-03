// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponseModel _$TokenResponseModelFromJson(Map<String, dynamic> json) =>
    TokenResponseModel(
      refresh: json['refresh'] as String?,
      access: json['access'] as String?,
      id: json['id'] as int?,
      email: json['email'] as String?,
      code: json['code'] as String?,
      done: json['done'] as bool?,
    );

Map<String, dynamic> _$TokenResponseModelToJson(TokenResponseModel instance) =>
    <String, dynamic>{
      'refresh': instance.refresh,
      'access': instance.access,
      'id': instance.id,
      'email': instance.email,
      'code': instance.code,
      'done': instance.done,
    };
