// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      token: json['jwt'] as String,
      fullName: json['fullName'] as String,
      id: json['_id'] as String,
      coins: json['coins'] as int,
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'jwt': instance.token,
      'fullName': instance.fullName,
      '_id': instance.id,
      'coins': instance.coins,
    };
