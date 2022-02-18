import 'package:blog/src/domain/repository/secure_storage_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataSecureStorageRepository implements SecureStorageRepository {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<Map<String, String>> readAll() {
    Future<Map<String, String>> result = _storage.readAll();
    return result;
  }

  @override
  Future<void> write(key, value) async {
    await _storage.write(key: key, value: value);
  }
}
