import 'package:blog/src/domain/repository/secure_storage_repository.dart';

class GetSecureValue {
  final SecureStorageRepository _repository;
  GetSecureValue(this._repository);

  Future<Map<String, String>> readAll() async {
    try {
      return await _repository.readAll();
    } catch (e) {
      rethrow;
    }
  }
}
