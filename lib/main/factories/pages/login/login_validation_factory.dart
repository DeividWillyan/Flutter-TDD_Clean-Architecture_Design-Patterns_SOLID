import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';

Validation makeLoginValidation() => ValidationComposite(makeLoginValidations());

makeLoginValidations() =>
    [RequiredFieldValidation('email'), EmailValidation('email'), RequiredFieldValidation('password')];
