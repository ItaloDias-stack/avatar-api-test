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

  @override
  @GET(
    "/v1/assets?page={page}&limit=50&filter=viewable-by-user-and-app&filterUserId={userId}&filterApplicationId=65ccd07a656645cd295a2771&order=editorPosition&type={type}&gender={gender}&gender=neutral&filterAllowLocked=true",
  )
  Future getAssets({
    @Path("page") required int page,
    @Path("userId") required String filterUserId,
    @Path("gender") required String gender,
    @Path("type") required String type,
  });

  @override
  @GET(
    "/v2/avatars/{userId}/colors?type={type}",
  )
  Future getColors({
    @Path("userId") required String userId,
    @Path("type") required String type,
  });

  @override
  @PATCH(
    "/v2/avatars/{idAvatar}",
  )
  Future updateAvatar({
    @Body() required Map<String, dynamic> body,
    @Path("idAvatar") required String idAvatar,
  });
}
