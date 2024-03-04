abstract class IGetColorsUseCase {
  Future<List<String>> call({
    required String type,
    required String userId,
  });
}
