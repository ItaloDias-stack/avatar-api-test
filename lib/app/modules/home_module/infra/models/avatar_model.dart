import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_leap_v2/app/modules/home_module/domain/entities/avatar_entity.dart';

part "avatar_model.g.dart";

@JsonSerializable()
class AvatarModel extends AvatarEntity {
  const AvatarModel({
    String id = "",
    String partner = '',
    Map<String, dynamic> assets = const {},
    String bodyType = "",
    String gender = "",
  }) : super(
          id: id,
          assets: assets,
          bodyType: bodyType,
          gender: gender,
          partner: partner,
        );

  factory AvatarModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarModelToJson(this);
}
