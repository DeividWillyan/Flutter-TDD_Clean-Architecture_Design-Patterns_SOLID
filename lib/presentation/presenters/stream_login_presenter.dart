import 'dart:async';
import 'package:meta/meta.dart';

import '../protocols/protocols.dart';

class LoginState {
  String emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  StreamLoginPresenter({@required this.validation});

  final _streamController = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  Stream get emailErrorStream => _streamController.stream.map((state) => state.emailError).distinct();

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _streamController.add(_state);
  }
}
