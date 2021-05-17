import 'dart:async';
import 'package:meta/meta.dart';

import '../../ui/pages/pages.dart';

import '../../domain/usecases/usecases.dart';
import '../../domain/helpers/helpers.dart';

import '../protocols/protocols.dart';

class LoginState {
  String email;
  String emailError;
  String password;
  String passwordError;
  bool isLoading = false;
  String navigateTo;

  String mainError;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  StreamLoginPresenter({
    @required this.validation,
    @required this.authentication,
  });

  var _streamController = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  Stream get emailErrorStream =>
      _streamController?.stream?.map((state) => state.emailError)?.distinct();
  Stream get passwordErrorStream => _streamController?.stream
      ?.map((state) => state.passwordError)
      ?.distinct();
  Stream get mainErrorStream =>
      _streamController?.stream?.map((state) => state.mainError)?.distinct();
  Stream get isValidFormStream =>
      _streamController?.stream?.map((state) => state.isFormValid)?.distinct();
  Stream get isLoadingStream =>
      _streamController?.stream?.map((state) => state.isLoading)?.distinct();
  Stream get navigateToStream =>
      _streamController?.stream?.map((state) => state.navigateTo)?.distinct();

  void _update() => _streamController?.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _update();
  }

  Future<void> auth() async {
    _state.isLoading = true;
    _update();
    try {
      await authentication.auth(
        AuthenticationParams(email: _state.email, secret: _state.password),
      );
    } on DomainError catch (error) {
      _state.mainError = error.description;
    }
    _state.isLoading = false;
    _update();
  }

  dispose() {
    _streamController.close();
    _streamController = null;
  }
}
