// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranked_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankedUser _$RankedUserFromJson(Map<String, dynamic> json) => RankedUser(
      json['_id'] as String,
      json['fullName'] as String,
      json['coins'] as int,
    );

Map<String, dynamic> _$RankedUserToJson(RankedUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'coins': instance.coins,
    };
