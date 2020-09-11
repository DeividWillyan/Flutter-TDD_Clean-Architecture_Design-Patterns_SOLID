class AccountEntity {
  final String token;

  AccountEntity(this.token);

  factory AccountEntity.fromMap(Map map) {
    if (map == null) return null;
    return AccountEntity(map['accessToken']);
  }
}
