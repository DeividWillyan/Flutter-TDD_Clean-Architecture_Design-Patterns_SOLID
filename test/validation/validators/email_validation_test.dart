import 'package:faker/faker.dart';
import 'package:flutter_avancado/validation/validators/validators.dart';
import 'package:test/test.dart';

main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), isNull);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), isNull);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate(faker.internet.email()), isNull);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('email_invalid'), 'Campo inválido.');
  });
}
