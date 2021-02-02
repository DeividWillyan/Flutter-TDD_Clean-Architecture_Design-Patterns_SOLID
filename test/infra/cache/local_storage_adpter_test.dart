import 'package:faker/faker.dart';
import 'package:flutter_avancado/infra/cache/cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

main() {
  FlutterSecureStorageSpy secureStorage;
  LocalStorageAdpter sut;
  String key;
  String value;
  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdpter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  group('saveSecure', () {
    test('Should call save secure with correct values', () async {
      await sut.saveSecure(key: key, value: value);

      verify(secureStorage.write(key: key, value: value));
    });

    test('Should throw if save secure throws', () async {
      when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenThrow(Exception());

      final result = sut.saveSecure(key: key, value: value);

      expect(result, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    test('Should call fetch secure with correct value', () async {
      await sut.fetchSecure(key);

      verify(secureStorage.read(key: key)).called(1);
    });

    test('Should return correct value on success', () async {
      when(secureStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => value);

      final result = await sut.fetchSecure(key);

      expect(result, value);
    });

    test('Should throw if fetch secure throws', () async {
      when(secureStorage.read(key: anyNamed('key'))).thenThrow(Exception());

      final result = sut.fetchSecure(key);

      expect(result, throwsA(TypeMatcher<Exception>()));
    });
  });
}
