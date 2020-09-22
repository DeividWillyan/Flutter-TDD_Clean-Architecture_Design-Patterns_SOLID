abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get passwordErrorStream;
  Stream get isValidFormStream;
  Stream get isLoadingStream;
  Stream get mainErrorStream;
  Stream get navigateToStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
  void dispose();
}
