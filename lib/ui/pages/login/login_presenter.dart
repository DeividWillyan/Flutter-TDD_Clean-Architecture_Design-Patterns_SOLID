abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get passwordErrorStream;
  Stream get isValidFormStream;
  Stream get isLoadingStream;
  Stream get mainErrorStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
  void dispose();
}
