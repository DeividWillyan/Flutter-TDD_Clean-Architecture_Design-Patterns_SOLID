import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:flutter_avancado/data/cache/cache.dart';

class LocalStorageAdpter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;
  LocalStorageAdpter({@required this.secureStorage});

  @override
  Future<void> saveSecure({@required String key, @required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}

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

  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: key, value: value);

    verify(secureStorage.write(key: key, value: value));
  });

  test('Should throw if save secure throws', () async {
    when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value'))).thenThrow(Exception());

    final result = sut.saveSecure(key: key, value: value);

    expect(result, throwsA(TypeMatcher<Exception>()));
  });
}
