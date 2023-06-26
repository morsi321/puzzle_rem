import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String fullName;
  final String email;
  final String password;
  final int age;
  final String phone;
  final String city;
  final String country;
  final String maritalStatus;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.age,
    required this.phone,
    required this.city,
    required this.country,
    required this.maritalStatus,
  });
  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
