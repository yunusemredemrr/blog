import 'package:blog/src/domain/model/account.dart';

abstract class AccountRepository {
  Future<Account> getAccount(token);
}
