// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceEntityData _$DeviceEntityDataFromJson(Map json) => DeviceEntityData(
  id: json['id'] as String?,
  creationDate: DateTime.parse(json['creationDate'] as String),
  lastUpdateDate: DateTime.parse(json['lastUpdateDate'] as String),
  installationId: json['installationId'] as String,
  token: json['token'] as String,
  operatingSystem: $enumDecode(
    _$OperatingSystemEnumMap,
    json['operatingSystem'],
  ),
);

Map<String, dynamic> _$DeviceEntityDataToJson(DeviceEntityData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creationDate': instance.creationDate.toIso8601String(),
      'lastUpdateDate': instance.lastUpdateDate.toIso8601String(),
      'installationId': instance.installationId,
      'token': instance.token,
      'operatingSystem': _$OperatingSystemEnumMap[instance.operatingSystem]!,
    };

const _$OperatingSystemEnumMap = {
  OperatingSystem.ios: 'ios',
  OperatingSystem.android: 'android',
};
