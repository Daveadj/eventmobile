import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyUserName = 'username';
  static const _keyToken = 'token';
  static const _keyUserid = 'userid';

  static Future setUsername(String username) async =>
      await _storage.write(key: _keyUserName, value: username);

  static Future<String?> getUserName() async =>
      await _storage.read(key: _keyUserName);
  static Future setToken(String token) async =>
      await _storage.write(key: _keyToken, value: token);

  static Future<String?> getToken() async =>
      await _storage.read(key: _keyToken);
  static Future setUserid(String userid) async =>
      await _storage.write(key: _keyUserid, value: userid);

  static Future<String?> getUserid() async =>
      await _storage.read(key: _keyUserid);

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
