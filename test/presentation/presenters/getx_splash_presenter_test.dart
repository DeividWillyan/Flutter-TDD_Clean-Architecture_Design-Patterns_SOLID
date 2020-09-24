import 'package:flutter_avancado/domain/usecases/usecases.dart';
import 'package:flutter_avancado/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  GetxSplashPresenter({this.loadCurrentAccount});

  var _navigateTo = RxString();

  @override
  Future<void> checkAccount() async => await loadCurrentAccount.load();

  @override
  Stream get navigateToStream => _navigateTo.stream;
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

main() {
  test('Should call LoadCurrentAccount', () async {
    final loadCurrentAccount = LoadCurrentAccountSpy();
    final sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);

    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}
