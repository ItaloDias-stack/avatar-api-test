import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_models_repository.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_2d_avatar_model_uc.dart';
import 'package:get_it/get_it.dart';

class Get2dAvatarModelUseCase implements IGet2dAvatarModelUseCase {
  @override
  Future call({required String params}) async {
    return await GetIt.I.get<IModelsRepository>().getAvatar2dImage(
          params: params,
        );
  }
}
