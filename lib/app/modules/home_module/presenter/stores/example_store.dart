import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_create_avatar_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_2d_avatar_model_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_auth_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_save_avatar_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/models/avatar_model.dart';
import 'package:flutter_leap_v2/shared/utils/authentication.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'dart:typed_data';
import '../../../../../shared/utils/app_state.dart';
import '../../../../../shared/utils/misc.dart';

part 'example_store.g.dart';

class ExampleStore = _ExampleStore with _$ExampleStore;

abstract class _ExampleStore with Store {
  @observable
  AppState appState = AppState.loaded;
  @observable
  String userId = "";

  @observable
  AvatarModel avatar3d = const AvatarModel();

  @action
  void changeAppState(AppState state) {
    appState = state;
  }

  @action
  Future<void> auth() async {
    try {
      changeAppState(AppState.loading);
      var example = await GetIt.I.get<IGetAuthUseCase>()();
      userId = example["data"]["id"];
      await Authentication.saveToken(example["data"]["token"]);
      changeAppState(AppState.loaded);
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("ExampleStore.auth", e, s);
    }
  }

  @action
  Future createAvatar({required File image}) async {
    try {
      changeAppState(AppState.loading);
      final bytes = await image.readAsBytes();
      avatar3d = await GetIt.I.get<ICreateAvatarUseCase>()(
        body: {
          "data": {
            "assets": {"outfit": "146130138"},
            "partner": "avatar-vivo-rpmy8o",
            "bodyType": "fullbody",
            "userId": userId,
            "base64Image": base64Encode(bytes),
          }
        },
      );
      log("avatar id: ${avatar3d.id}");
      await saveAvatar();
      //  changeAppState(AppState.loaded);
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("ExampleStore.createAvatar", e, s);
    }
  }

  Future saveAvatar() async {
    try {
      await GetIt.I.get<ISaveAvatarUseCase>()(
        idAvatar: avatar3d.id,
      );
      await getAvatar2dImage();
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("ExampleStore.createAvatar", e, s);
    }
  }

  Future getAvatar2dImage() async {
    try {
      await GetIt.I.get<IGet2dAvatarModelUseCase>()(
        params:
            "${avatar3d.id}.png?expression=happy&pose=power-stance&camera=portrait",
      );
      changeAppState(AppState.loaded);
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("ExampleStore.createAvatar", e, s);
    }
  }
}
