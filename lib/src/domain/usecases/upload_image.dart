import 'package:blog/src/domain/model/image_model.dart';
import 'package:blog/src/domain/repository/account_repository.dart';

class UploadImage {
  final AccountRepository _repository;
  UploadImage(this._repository);

  Future<ImageModel> uploadImage(token, body) async {
    try {
      return await _repository.uploadImage(token, body);
    } catch (e) {
      rethrow;
    }
  }
}
