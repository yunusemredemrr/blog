abstract class SecureStorageRepository {
  Future<void> write(key, value);
  Future<Map<String, String>> readAll();
  Future<void> deleteAll();
}
