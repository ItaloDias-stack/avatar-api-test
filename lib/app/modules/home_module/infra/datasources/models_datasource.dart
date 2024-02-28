import 'package:dio/dio.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_models_repository.dart';
import 'package:retrofit/retrofit.dart';
part "models_datasource.g.dart";

@RestApi()
abstract class ModelsDatasource implements IModelsRepository {
  factory ModelsDatasource(Dio dio, {String baseUrl}) = _ModelsDatasource;

  @override
  @GET("/{params}")
  Future getAvatar2dImage({
    @Path("params") required String params,
  });
}
