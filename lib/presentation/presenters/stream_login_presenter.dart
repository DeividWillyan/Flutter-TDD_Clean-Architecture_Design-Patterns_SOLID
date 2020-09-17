import 'dart:async';
import 'package:meta/meta.dart';

import '../protocols/protocols.dart';

class LoginState {
  String emailError;
  String passwordError;
  bool get isFormValid => false;
}

class StreamLoginPresenter {
  final Validation validation;
  StreamLoginPresenter({@required this.validation});

  final _streamController = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  Stream get emailErrorStream => _streamController.stream.map((state) => state.emailError).distinct();
  Stream get passwordErrorStream => _streamController.stream.map((state) => state.passwordError).distinct();
  Stream get isFormValidStream => _streamController.stream.map((state) => state.isFormValid).distinct();

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _streamController.add(_state);
  }

  void validatePassword(String password) {
    _state.passwordError = validation.validate(field: 'password', value: password);
    _streamController.add(_state);
  }
}
