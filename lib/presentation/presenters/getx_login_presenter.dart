import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../ui/pages/pages.dart';

import '../../domain/usecases/usecases.dart';
import '../../domain/helpers/helpers.dart';

import '../protocols/protocols.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;
  GetxLoginPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccount,
  });

  String _email;
  String _password;
  var _emailError = RxString();
  var _passwordError = RxString();
  var _mainError = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;
  var _navigateTo = RxString();

  Stream get emailErrorStream => _emailError.stream;
  Stream get passwordErrorStream => _passwordError.stream;
  Stream get mainErrorStream => _mainError.stream;
  Stream get isValidFormStream => _isFormValid.stream;
  Stream get isLoadingStream => _isLoading.stream;
  Stream get navigateToStream => _navigateTo.stream;

  void _validateForm() => _isFormValid.value = _emailError.value == null &&
      _passwordError.value == null &&
      _email != null &&
      _password != null;

  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: password);
    _validateForm();
  }

  Future<void> auth() async {
    try {
      _isLoading.value = true;
      final result = await authentication
          .auth(AuthenticationParams(email: _email, secret: _password));
      await saveCurrentAccount.save(result);
      _navigateTo.value = '/surveys';
    } on DomainError catch (error) {
      _mainError.value = error.description;
      _isLoading.value = false;
    }
  }

  dispose() {}
}
