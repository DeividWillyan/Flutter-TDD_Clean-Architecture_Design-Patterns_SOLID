import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_avancado/validation/protocols/protocols.dart';
import 'package:flutter_avancado/validation/validators/validators.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  ValidationComposite sut;
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;

  void mockValidation(
    FieldValidationSpy validation,
    String error, {
    String field = 'any_field',
  }) {
    when(validation.field).thenReturn(field);
    when(validation.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    mockValidation(validation1, null);

    validation2 = FieldValidationSpy();
    mockValidation(validation2, null);

    sut = ValidationComposite([validation1, validation2]);
  });

  test('Shold return null if all validations returns null or empty', () {
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('Shold return primary error in ValidationComposite', () {
    mockValidation(validation1, 'error_1');
    mockValidation(validation2, 'error_2', field: 'other_field');

    final error = sut.validate(field: 'other_field', value: 'any_value');

    expect(error, 'error_2');
  });
}
