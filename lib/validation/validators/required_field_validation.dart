import 'package:equatable/equatable.dart';

import '../protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;
  RequiredFieldValidation(this.field);

  @override
  String validate(String value) => value?.isNotEmpty == true ? null : 'Campo obrigatório.';

  @override
  List<Object> get props => [field];
}
