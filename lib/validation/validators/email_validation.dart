import 'package:equatable/equatable.dart';

import '../protocols/protocols.dart';

class EmailValidation extends Equatable implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  @override
  String validate(String value) =>
      value?.isNotEmpty != true || value.contains('@')
          ? null
          : 'Campo inválido.';

  @override
  List<Object> get props => [field];
}
