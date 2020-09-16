abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get passwordErrorStream;
  Stream get isValidFormStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
}
