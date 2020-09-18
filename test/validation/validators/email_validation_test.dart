import 'package:flutter_avancado/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  @override
  String validate(String value) => null;
}

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
}
