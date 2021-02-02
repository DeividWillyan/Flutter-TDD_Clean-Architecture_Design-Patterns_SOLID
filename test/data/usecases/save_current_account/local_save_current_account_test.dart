import 'package:faker/faker.dart';
import 'package:flutter_avancado/data/cache/cache.dart';
import 'package:flutter_avancado/data/usecases/usecases.dart';
import 'package:flutter_avancado/domain/entities/entities.dart';
import 'package:flutter_avancado/domain/helpers/helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  SaveSecureCacheStorageSpy saveSecureCacheStorage;
  LocalSaveCurrentAccout sut;
  AccountEntity account;

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut =
        LocalSaveCurrentAccout(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    when(saveSecureCacheStorage.saveSecure(
            key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    final result = sut.save(account);

    expect(result, throwsA(DomainError.unexpected));
  });
}
