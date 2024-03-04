import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_avatar_repository.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_update_avatar_uc.dart';
import 'package:get_it/get_it.dart';

class UpdateAvatarUseCase implements IUpdateAvatarUseCase {
  @override
  Future call(
      {required String idAvatar, required Map<String, dynamic> body}) async {
    return await GetIt.I.get<IAvatarRepository>().updateAvatar(
          body: body,
          idAvatar: idAvatar,
        );
  }
}
