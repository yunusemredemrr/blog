import 'package:blog/src/domain/model/account.dart';
import 'package:blog/src/domain/types/enums/account_view_state.dart';
import 'package:blog/src/domain/usecases/get_account.dart';
import 'package:flutter/widgets.dart';

import '../../../locator.dart';

class AccountViewModel extends ChangeNotifier {
  AccountViewState _accountViewState = AccountViewState.Idle;
  String token;

  Account? account;

  AccountViewState get accountViewState => _accountViewState;

  set accountViewState(AccountViewState value) {
    _accountViewState = value;
    notifyListeners();
  }

  AccountViewModel(this.token) {
    _accountViewState = AccountViewState.Idle;
    getAccount();
  }

  getAccount() async {
    try {
      accountViewState = AccountViewState.Bussy;
      Account _currentAccount =
          await locator.get<GetAccount>().getAccount(token);
      if (!_currentAccount.hasError!) {
        account = _currentAccount;
      }
    } catch (e) {
      print(e);
    } finally {
      accountViewState = AccountViewState.Loaded;
    }
  }
}
