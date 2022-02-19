import 'package:blog/src/domain/model/account.dart';
import 'package:blog/src/domain/repository/account_repository.dart';

class GetAccount {
  final AccountRepository _repository;
  GetAccount(this._repository);

  Future<Account> getAccount(token) async {
    try {
      return await _repository.getAccount(token);
    } catch (e) {
      rethrow;
    }
  }
}
