import 'package:flutter/material.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_auth_repository.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_avatar_repository.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_models_repository.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/get_2d_avatar_model_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/get_auth_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_2d_avatar_model_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_auth_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_save_avatar_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/save_avatar_uc.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/datasources/auth_datasource.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/datasources/avatar_datasource.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/datasources/models_datasource.dart';
import 'package:flutter_leap_v2/shared/utils/dio_config.dart';

import '../../../shared/common/default_module.dart';
import '../../../shared/injector/i_dependency_injector.dart';
import '../../../shared/common/route_module.dart';

import 'domain/usecases/create_avatar_uc.dart';
import 'domain/usecases/intefaces/i_create_avatar_uc.dart';
import 'presenter/pages/home_screen.dart';
import 'presenter/pages/home_screen_middleware.dart';
import 'presenter/stores/example_store.dart';

class HomeModule implements DefaultModule {
  final HomeRouteModule _routeModule = HomeRouteModule();

  @override
  Map<String, WidgetBuilder> get routes => _routeModule.routes;

  @override
  void registerDependencies(IDependencyInjector? injector) {
    injector?.registerSingleton<IAuthRepository>(
      AuthDatasource(
        DioConfig().dio,
        baseUrl: "",
      ),
    );
    injector?.registerSingleton<IAvatarRepository>(
      AvatarDatasource(
        DioConfig().dio,
      ),
    );
    injector?.registerSingleton<IModelsRepository>(
      ModelsDatasource(
        DioConfig().dio,
        baseUrl: "https://models.readyplayer.me",
      ),
    );
    injector?.registerSingleton<ExampleStore>(ExampleStore());
    injector?.registerSingleton<ICreateAvatarUseCase>(CreateAvatarUseCase());
    injector?.registerSingleton<IGetAuthUseCase>(
      GetAuthUseCase(),
    );
    injector?.registerSingleton<ISaveAvatarUseCase>(
      SaveAvatarUseCase(),
    );
    injector?.registerSingleton<IGet2dAvatarModelUseCase>(
      Get2dAvatarModelUseCase(),
    );
  }

  @override
  RouteModule get routeModule => _routeModule;
}

class HomeRouteModule implements RouteModule {
  @override
  Map<String, WidgetBuilder> get routes => {
        HomeScreen.routeName: (_) => const HomeScreen(),
        HomeScreenMiddleware.routeName: (_) => const HomeScreenMiddleware(),
        // outras possíveis rotas aqui...
      };
}
