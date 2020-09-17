import 'dart:async';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

abstract class Validation {
  validate({@required String field, @required String value});
}

class LoginState {
  String emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  StreamLoginPresenter({@required this.validation});

  final _streamController = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  Stream get emailErrorStream => _streamController.stream.map((state) => state.emailError);

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _streamController.add(_state);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;

  PostExpectation mockValidationCall({String field}) =>
      when(validation.validate(field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({String field, String value}) => mockValidationCall(field: field).thenReturn(value);

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();

    mockValidation();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validations fails', () {
    mockValidation(value: 'error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}
