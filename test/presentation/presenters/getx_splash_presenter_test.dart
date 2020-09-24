import 'package:faker/faker.dart';
import 'package:flutter_avancado/domain/entities/entities.dart';
import 'package:flutter_avancado/domain/usecases/usecases.dart';
import 'package:flutter_avancado/presentation/presenters/presenters.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

main() {
  LoadCurrentAccountSpy loadCurrentAccount;
  GetxSplashPresenter sut;

  mockLoadCurrentAccount({AccountEntity account}) =>
      when(loadCurrentAccount.load()).thenAnswer((_) async => account);

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);

    mockLoadCurrentAccount(account: AccountEntity(faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to Login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to Login page on error', () async {
    when(loadCurrentAccount.load()).thenThrow(Exception());

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });
}
