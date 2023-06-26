import 'package:json_annotation/json_annotation.dart';

part 'ranked_user.g.dart';

@JsonSerializable()
class RankedUser {
  @JsonKey(name: '_id')
  final String id;
  final String fullName;
  final int coins;

  RankedUser(this.id, this.fullName, this.coins);

  factory RankedUser.fromJson(Map<String, dynamic> json) =>
      _$RankedUserFromJson(json);

  Map<String, dynamic> toJson() => _$RankedUserToJson(this);
}
