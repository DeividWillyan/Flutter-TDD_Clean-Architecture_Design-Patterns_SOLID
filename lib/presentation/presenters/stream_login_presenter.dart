import 'dart:async';
import 'package:meta/meta.dart';

import '../protocols/protocols.dart';

class LoginState {
  String email;
  String emailError;
  String password;
  String passwordError;
  bool get isFormValid => emailError == null && passwordError == null && email != null && password != null;
}

class StreamLoginPresenter {
  final Validation validation;
  StreamLoginPresenter({@required this.validation});

  final _streamController = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  Stream get emailErrorStream => _streamController.stream.map((state) => state.emailError).distinct();
  Stream get passwordErrorStream => _streamController.stream.map((state) => state.passwordError).distinct();
  Stream get isFormValidStream => _streamController.stream.map((state) => state.isFormValid).distinct();

  void _update() => _streamController.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validation.validate(field: 'password', value: password);
    _update();
  }
}
