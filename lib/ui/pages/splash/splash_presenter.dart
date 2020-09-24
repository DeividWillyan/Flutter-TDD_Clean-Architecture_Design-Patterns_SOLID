abstract class SplashPresenter {
  Stream get navigateToStream;
  Future<void> checkAccount({int durationInSeconds = 3});
}
