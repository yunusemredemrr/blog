import 'package:blog/src/domain/model/update.dart';
import 'package:blog/src/domain/repository/account_repository.dart';

class UpdateAccount {
  final AccountRepository _repository;
  UpdateAccount(this._repository);

  Future<Update> updateAccount(token, body) async {
    try {
      return await _repository.updateAccount(token, body);
    } catch (e) {
      rethrow;
    }
  }
}
