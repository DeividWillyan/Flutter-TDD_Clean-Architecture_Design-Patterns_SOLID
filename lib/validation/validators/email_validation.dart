import '../protocols/protocols.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  @override
  String validate(String value) =>
      value?.isNotEmpty != true || value.contains('@') ? null : 'Campo inválido.';
}
