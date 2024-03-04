import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_create_avatar_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_2d_avatar_model_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_assets_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_auth_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_colors_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_save_avatar_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_update_avatar_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/models/asset_model.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/models/avatar_model.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/avatar_screen.dart';
import 'package:flutter_leap_v2/shared/utils/app_global_context.dart';
import 'package:flutter_leap_v2/shared/utils/authentication.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import '../../../../../shared/utils/app_state.dart';
import '../../../../../shared/utils/misc.dart';

part 'avatar_store.g.dart';

class AvatarStore = _AvatarStore with _$AvatarStore;

abstract class _AvatarStore with Store {
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

  @observable
  ObservableList<AssetModel> assets = ObservableList.of([]);

  @observable
  String selectedAssetType = "";

  @observable
  ObservableList<String> assetColors = ObservableList.of([]);

  @observable
  File image = File("");

  @observable
  int? page = 1;
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
      printException("AvatarStore.auth", e, s);
    }
  }

  @action
  Future createAvatar({required File image}) async {
    try {
      this.image = image;
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
      printException("AvatarStore.createAvatar", e, s);
    }
  }

  @action
  Future saveAvatar() async {
    try {
      await GetIt.I.get<ISaveAvatarUseCase>()(
        idAvatar: avatar3d.id,
      );
      await getAvatar2dImage();
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("AvatarStore.createAvatar", e, s);
    }
  }

  @action
  Future getAvatar2dImage() async {
    try {
      await GetIt.I.get<IGet2dAvatarModelUseCase>()(
        params:
            "${avatar3d.id}.png?camera=portrait&blendShapes[mouthSmile]=0.5&background=102,0,153",
      );
      changeAppState(AppState.loaded);
      GlobalAppContext.pushNamed(
        AvatarScreen.routeName,
      );
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("AvatarStore.createAvatar", e, s);
    }
  }

  @action
  Future getAssets({required String type}) async {
    try {
      if (type != selectedAssetType) {
        page = 1;
        assets.clear();
        changeAppState(AppState.loading);
      } else {
        changeAppState(AppState.loadingMore);
      }
      selectedAssetType = type;
      if (page != null) {
        var response = await GetIt.I.get<IGetAssetsUseCase>()(
          filterUserId: userId,
          gender: avatar3d.gender,
          type: type,
          page: page!,
        );

        if (response.isNotEmpty) {
          page = page! + 1;
        } else {
          page = null;
        }
        assets.addAll(response);
      }
      changeAppState(AppState.loaded);
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("AvatarStore.getAssets", e, s);
    }
  }

  @action
  Future getAssetColors({required String type}) async {
    try {
      changeAppState(AppState.loading);
      selectedAssetType = type;
      assetColors.clear();
      var response = await GetIt.I.get<IGetColorsUseCase>()(
        type: selectedAssetType,
        userId: avatar3d.id,
      );
      if (response.isNotEmpty) {
        assetColors.addAll(response);
      }
      changeAppState(AppState.loaded);
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("AvatarStore.getAssetColors", e, s);
    }
  }

  @action
  Future updateAvatar(
      {required String assetKey, required String assetValue}) async {
    try {
      changeAppState(AppState.loading);
      await GetIt.I.get<IUpdateAvatarUseCase>()(
        body: {
          "data": {
            "assets": {assetKey: assetValue},
          },
        },
        idAvatar: avatar3d.id,
      );
      avatar3d.assets[assetKey] = assetValue;
      await saveAvatar();
      changeAppState(AppState.loaded);
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("AvatarStore.updateAvatar", e, s);
    }
  }
}
