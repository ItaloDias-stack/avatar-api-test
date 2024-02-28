import 'package:flutter_leap_v2/app/modules/home_module/infra/models/avatar_model.dart';
import 'package:get_it/get_it.dart';

import '../repositories/i_avatar_repository.dart';

import 'intefaces/i_create_avatar_uc.dart';

class CreateAvatarUseCase implements ICreateAvatarUseCase {
  @override
  Future<AvatarModel> call({
    required Map<String, dynamic> body,
  }) async {
    var response =
        await GetIt.I.get<IAvatarRepository>().createAvatar(body: body);
    return AvatarModel.fromJson(response["data"]);
  }
}
