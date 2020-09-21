import 'package:flutter_avancado/main/factories/pages/login/login_validation_factory.dart';
import 'package:flutter_avancado/main/factories/usecases/authentication_factory.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

LoginPresenter makeStreamLoginPresenter() =>
    StreamLoginPresenter(validation: makeLoginValidation(), authentication: makeAuthentication());

LoginPresenter makeGetxLoginPresenter() =>
    GetxLoginPresenter(validation: makeLoginValidation(), authentication: makeAuthentication());
