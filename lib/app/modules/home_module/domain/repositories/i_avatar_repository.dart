abstract class IAvatarRepository {
  Future createAvatar({
    required Map<String, dynamic> body,
  });

  Future saveAvatar({
    required String id,
  });

  Future getAssets({
    required int page,
    required String filterUserId,
    required String gender,
    required String type,
  });

  Future getColors({
    required String userId,
    required String type,
  });

  Future updateAvatar({
    required Map<String, dynamic> body,
    required String idAvatar,
  });
}
