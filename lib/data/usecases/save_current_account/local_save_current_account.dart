import 'package:meta/meta.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

import '../../cache/cache.dart';

class LocalSaveCurrentAccout implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;
  LocalSaveCurrentAccout({@required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    try {
      saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
