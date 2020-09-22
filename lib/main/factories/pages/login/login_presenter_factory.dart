import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

import '../../factories.dart';

LoginPresenter makeStreamLoginPresenter() =>
    StreamLoginPresenter(validation: makeLoginValidation(), authentication: makeAuthentication());

LoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
      validation: makeLoginValidation(),
      authentication: makeAuthentication(),
      saveCurrentAccount: makeLocalSaveCurrentAccount(),
    );
