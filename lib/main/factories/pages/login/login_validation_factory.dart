import 'package:flutter_avancado/main/builders/builders.dart';

import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';

Validation makeLoginValidation() => ValidationComposite(makeLoginValidations());

makeLoginValidations() => [
      ...ValidationBuilder.field('email').required().email().build(),
      ...ValidationBuilder.field('password').required().build(),
    ];
