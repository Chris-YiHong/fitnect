// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_entity.freezed.dart';
part 'device_entity.g.dart';

enum OperatingSystem {
  @JsonValue('ios')
  ios,
  @JsonValue('android')
  android,
}

@freezed
sealed class DeviceEntity with _$DeviceEntity {
  const factory DeviceEntity({
    String? id,
    required DateTime creationDate,
    required DateTime lastUpdateDate,
    required String installationId,
    required String token,
    required OperatingSystem operatingSystem,
  }) = DeviceEntityData;

  const DeviceEntity._();

  factory DeviceEntity.fromJson(Map<String, Object?> json) =>
      _$DeviceEntityFromJson(json);

  factory DeviceEntity.fromPrefs(Map<String, dynamic> json) {
    final installationId = json['installationId'] as String?;
    return _$DeviceEntityFromJson(json..['id'] = installationId);
  }

  Map<String, dynamic> toJsonForPrefs() => toJson();
}
