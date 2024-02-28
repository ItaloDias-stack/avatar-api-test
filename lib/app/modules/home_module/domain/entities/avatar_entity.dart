import 'package:flutter/foundation.dart';

@immutable
class AvatarEntity {
  final String id;
  final String bodyType;
  final String gender;
  final String partner;
  final Map<String, dynamic> assets;
  const AvatarEntity({
    this.id = "",
    this.partner = '',
    this.assets = const {},
    this.bodyType = "",
    this.gender = "",
  });

  AvatarEntity copyWith({
    String? id,
    String? gender,
    String? partner,
    String? bodyType,
    Map<String, dynamic>? assets,
  }) {
    return AvatarEntity(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      assets: assets ?? this.assets,
      bodyType: bodyType ?? this.bodyType,
      partner: partner ?? this.partner,
    );
  }
}
