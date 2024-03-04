import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_avatar_repository.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_assets_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/models/asset_model.dart';
import 'package:get_it/get_it.dart';

class GetAssetsUseCase implements IGetAssetsUseCase {
  @override
  Future<List<AssetModel>> call(
      {required String filterUserId,
      required String gender,
      required int page,
      required String type}) async {
    List<AssetModel> list = [];
    var response = await GetIt.I.get<IAvatarRepository>().getAssets(
          filterUserId: filterUserId,
          gender: gender,
          type: type,
          page: page,
        );
    for (var element in response["data"]) {
      list.add(
        AssetModel.fromJson(element),
      );
    }
    return list;
  }
}
