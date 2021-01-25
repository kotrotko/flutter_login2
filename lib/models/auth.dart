import 'package:flutter_login2/utils/storage.dart';

class AuthTokens {
  String accessToken;
  String refreshToken;

  AuthTokens({
    this.accessToken,
    this.refreshToken,
  });

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return new AuthTokens(
        accessToken: json["access"], refreshToken: json["refresh"]);
  }

  Map<String, dynamic> toJson() =>
      {"access": accessToken, "refresh": refreshToken};

  void save() async {
    if (accessToken == null || refreshToken == null) {
      await secureStorage.delete(key: 'accessToken');
      await secureStorage.delete(key: 'refreshToken');
    } else {
      await secureStorage.write(key: 'accessToken', value: accessToken);
      await secureStorage.write(key: 'refreshToken', value: refreshToken);
    }
  }
}

Future<AuthTokens> getCurrentTokens() async {
  if (await secureStorage.read(key: 'accessToken') == null ||
      await secureStorage.read(key: 'accessToken') == null) {
    return null;
  }
  return new AuthTokens(
      accessToken: await secureStorage.read(key: 'accessToken'),
      refreshToken: await secureStorage.read(key: 'refreshToken'));
}
