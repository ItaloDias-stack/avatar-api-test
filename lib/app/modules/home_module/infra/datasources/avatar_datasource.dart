import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/repositories/i_avatar_repository.dart';

part "avatar_datasource.g.dart";

@RestApi()
abstract class AvatarDatasource implements IAvatarRepository {
  factory AvatarDatasource(Dio dio, {String baseUrl}) = _AvatarDatasource;

  @override
  @POST("/v2/avatars")
  Future createAvatar({
    @Body() required Map<String, dynamic> body,
  });

  @override
  @PUT("/v2/avatars/{idAvatar}")
  Future saveAvatar({
    @Path("idAvatar") required String id,
  });
}
