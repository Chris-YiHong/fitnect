// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionEntityData _$SubscriptionEntityDataFromJson(Map json) =>
    SubscriptionEntityData(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$SubscriptionEntityDataToJson(
  SubscriptionEntityData instance,
) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  'user_id': instance.userId,
  'key': instance.key,
  'value': instance.value,
};
