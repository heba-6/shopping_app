import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppSecureStorage {
  final FlutterSecureStorage _storage;
  AppSecureStorage(this._storage);

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String> read(String key) async {
    String data = await _storage.read(key: key) ?? "";
    return data;
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
