import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "jwt")
  final String token;
  final String fullName;
  @JsonKey(name: "_id")
  final String id;
  final int coins;

  AuthResponse({
    required this.token,
    required this.fullName,
    required this.id,
    required this.coins,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
