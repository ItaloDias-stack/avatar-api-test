import 'package:flutter_leap_v2/app/modules/home_module/infra/models/avatar_model.dart';

abstract class ICreateAvatarUseCase {
  Future<AvatarModel> call({
    required Map<String, dynamic> body,
  });
}
