abstract class IUpdateAvatarUseCase {
  Future call({
    required String idAvatar,
    required Map<String, dynamic> body,
  });
}
