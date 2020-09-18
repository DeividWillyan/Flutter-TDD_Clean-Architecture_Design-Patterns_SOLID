import 'package:flutter_avancado/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any_value'), isNull);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Campo obrigatório.');
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), 'Campo obrigatório.');
  });
}
