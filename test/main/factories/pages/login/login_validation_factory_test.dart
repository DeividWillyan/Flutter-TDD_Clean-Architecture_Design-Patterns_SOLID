import 'package:flutter_avancado/main/factories/pages/login/login.dart';
import 'package:flutter_avancado/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validation', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
    ]);
  });
}
