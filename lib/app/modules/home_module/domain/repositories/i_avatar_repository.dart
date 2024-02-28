abstract class IAvatarRepository {
  Future createAvatar({
    required Map<String, dynamic> body,
  });

  Future saveAvatar({
    required String id,
  });
}
