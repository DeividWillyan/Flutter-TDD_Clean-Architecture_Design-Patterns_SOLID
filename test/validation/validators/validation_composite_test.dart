import 'package:flutter_avancado/validation/protocols/field_validation.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_avancado/presentation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;
  ValidationComposite(this.validations);

  @override
  validate({String field, String value}) {}
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  ValidationComposite sut;
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;

  void mockValidation(FieldValidationSpy validation, String error) {
    when(validation.field).thenReturn('any_field');
    when(validation.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    mockValidation(validation1, null);

    validation2 = FieldValidationSpy();
    mockValidation(validation2, '');

    sut = ValidationComposite([validation1, validation2]);
  });

  test('Shold return null if all validations returns null or empty', () {
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
