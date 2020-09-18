import 'package:flutter_avancado/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  @override
  String validate(String value) => null;
}

main() {
  test('Should return null if email is empty', () {
    final sut = EmailValidation('any_field');

    expect(sut.validate(''), isNull);
  });

  test('Should return null if email is null', () {
    final sut = EmailValidation('any_field');

    expect(sut.validate(null), isNull);
  });
}
