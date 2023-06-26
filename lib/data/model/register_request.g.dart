// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      age: json['age'] as int,
      phone: json['phone'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      maritalStatus: json['maritalStatus'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'age': instance.age,
      'phone': instance.phone,
      'city': instance.city,
      'country': instance.country,
      'maritalStatus': instance.maritalStatus,
    };
