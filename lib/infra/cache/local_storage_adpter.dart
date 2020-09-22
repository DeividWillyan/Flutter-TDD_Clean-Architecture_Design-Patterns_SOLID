import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../data/cache/cache.dart';

class LocalStorageAdpter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;
  LocalStorageAdpter({@required this.secureStorage});

  @override
  Future<void> saveSecure({@required String key, @required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}
