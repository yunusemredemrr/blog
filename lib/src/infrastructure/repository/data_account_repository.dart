import 'dart:convert';

import 'package:blog/src/domain/model/account.dart';
import 'package:blog/src/domain/repository/account_repository.dart';
import 'package:blog/src/domain/repository/base_repository.dart';
import 'package:blog/src/infrastructure/repository/data_base_repository.dart';
import 'package:http/http.dart';

class DataAccountRepository implements AccountRepository {
  static final _instance = DataAccountRepository._internal();
  DataAccountRepository._internal() : _baseRepository = DataBaseRepository();
  factory DataAccountRepository() => _instance;
  final BaseRepository _baseRepository;

  @override
  Future<Account> getAccount(token) async {
    Map<String, String> header = {
      "Access-Control_Allow_Origin": "*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    Response response =
        await _baseRepository.executeRequest("GET", "Account/Get", header);
    return Account.fromJson(json.decode(response.body));
  }
}
