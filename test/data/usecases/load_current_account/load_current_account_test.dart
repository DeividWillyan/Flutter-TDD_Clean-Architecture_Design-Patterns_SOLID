import 'package:faker/faker.dart';
import 'package:flutter_avancado/data/cache/cache.dart';
import 'package:flutter_avancado/data/usecases/usecases.dart';
import 'package:flutter_avancado/domain/entities/account_entity.dart';
import 'package:flutter_avancado/domain/helpers/helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}

main() {
  LocalLoadCurrentAccount sut;
  FetchSecureCacheStorage fetchSecureCacheStorage;
  String token;

  mockSuccess() => when(fetchSecureCacheStorage.fetchSecure(any)).thenAnswer((_) async => token);
  mockUnexpectedError() => when(fetchSecureCacheStorage.fetchSecure(any)).thenThrow(Exception());

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();

    mockSuccess();
  });

  test('Should call FetchSecureCacheStorage with corrent values', () async {
    await sut.load();

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token));
  });

  test('Should throw UnexpectedError if fetchSecureCacheStorage throws', () async {
    mockUnexpectedError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
