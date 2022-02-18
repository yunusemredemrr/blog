import 'package:blog/src/domain/repository/secure_storage_repository.dart';

class SetSecureValue {
  final SecureStorageRepository _repository;
  SetSecureValue(this._repository);

  Future<void> write(String value) async {
    try {
      return await _repository.write("jwl", value);
    } catch (e) {
      rethrow;
    }
  }
}
