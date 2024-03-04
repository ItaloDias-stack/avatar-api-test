import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_avatar_repository.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_colors_uc.dart';
import 'package:get_it/get_it.dart';

class GetColorsUseCase implements IGetColorsUseCase {
  @override
  Future<List<String>> call(
      {required String type, required String userId}) async {
    var response = await GetIt.I.get<IAvatarRepository>().getColors(
          userId: userId,
          type: type,
        );
    if (response["data"][type] is List) {
      return (response["data"][type] as List).map((e) => "$e").toList();
    } else {
      return [];
    }
  }
}
