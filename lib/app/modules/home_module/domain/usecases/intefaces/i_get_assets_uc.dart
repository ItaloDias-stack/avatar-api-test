import 'package:flutter_leap_v2/app/modules/home_module/infra/models/asset_model.dart';

abstract class IGetAssetsUseCase {
  Future<List<AssetModel>> call({
    required String filterUserId,
    required String gender,
    required String type,
    required int page,
  });
}
