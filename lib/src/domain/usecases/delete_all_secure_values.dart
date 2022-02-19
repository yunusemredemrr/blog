import 'package:blog/src/domain/repository/secure_storage_repository.dart';

class DeleteAllSecureValues {
  final SecureStorageRepository _repository;
  DeleteAllSecureValues(this._repository);

  Future<void> deleteAll() async {
    try {
      await _repository.deleteAll();
    } catch (e) {
      rethrow;
    }
  }
}
