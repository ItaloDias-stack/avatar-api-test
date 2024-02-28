import 'package:dio/dio.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_auth_repository.dart';
import 'package:retrofit/retrofit.dart';

part "auth_datasource.g.dart";

@RestApi()
abstract class AuthDatasource implements IAuthRepository {
  factory AuthDatasource(Dio dio, {String baseUrl}) = _AuthDatasource;

  @override
  @POST("https://avatar-vivo-rpmy8o.readyplayer.me/api/users")
  Future getRpmAuth();
}
