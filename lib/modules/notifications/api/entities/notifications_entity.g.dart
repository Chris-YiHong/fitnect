// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map json) => NotificationData(
  id: json['id'] as String?,
  title: json['title'] as String,
  creationDate: DateTime.parse(json['creationDate'] as String),
  body: json['body'] as String,
  readDate:
      json['readDate'] == null
          ? null
          : DateTime.parse(json['readDate'] as String),
  type: $enumDecodeNullable(_$NotificationTypesEnumMap, json['type']),
  data: (json['data'] as Map?)?.map((k, e) => MapEntry(k as String, e)),
);

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'creationDate': instance.creationDate.toIso8601String(),
      'body': instance.body,
      'readDate': instance.readDate?.toIso8601String(),
      'type': _$NotificationTypesEnumMap[instance.type],
      'data': instance.data,
    };

const _$NotificationTypesEnumMap = {
  NotificationTypes.WELCOME: 'WELCOME',
  NotificationTypes.OTHER: 'OTHER',
  NotificationTypes.LINK: 'LINK',
};
