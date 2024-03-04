import 'package:flutter/foundation.dart';

@immutable
class AssetEntity {
  final String id;
  final String name;
  final String gender;
  final String organizationId;
  final String type;
  final String iconUrl;
  const AssetEntity({
    this.id = "",
    this.name = '',
    this.type = "",
    this.organizationId = "",
    this.gender = "",
    this.iconUrl = "",
  });

  AssetEntity copyWith({
    String? id,
    String? name,
    String? gender,
    String? organizationId,
    String? type,
    String? iconUrl,
  }) {
    return AssetEntity(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      iconUrl: iconUrl ?? this.iconUrl,
      organizationId: organizationId ?? this.organizationId,
      type: type ?? this.type,
      name: name ?? this.name,
    );
  }
}
