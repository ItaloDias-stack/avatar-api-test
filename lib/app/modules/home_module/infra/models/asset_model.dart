import 'package:flutter_leap_v2/app/modules/home_module/domain/entities/asset_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part "asset_model.g.dart";

@JsonSerializable()
class AssetModel extends AssetEntity {
  const AssetModel({
    String id = "",
    String name = '',
    String organizationId = "",
    String type = "",
    String gender = "",
    String iconUrl = "",
  }) : super(
          id: id,
          name: name,
          type: type,
          gender: gender,
          iconUrl: iconUrl,
          organizationId: organizationId,
        );

  factory AssetModel.fromJson(Map<String, dynamic> json) =>
      _$AssetModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetModelToJson(this);
}
