import 'dart:convert';

import 'package:blog/src/domain/model/user.dart';
import 'package:blog/src/domain/repository/base_repository.dart';
import 'package:blog/src/domain/repository/user_repository.dart';
import 'package:blog/src/infrastructure/repository/data_base_repository.dart';
import 'package:http/http.dart';

class DataUserRepository implements UserRepository {
  static final _instance = DataUserRepository._internal();
  DataUserRepository._internal() : _baseRepository = DataBaseRepository();
  factory DataUserRepository() => _instance;
  final BaseRepository _baseRepository;

  Map<String, String> header = {
    "Access-Control_Allow_Origin": "*",
    "Content-Type": "application/json",
  };
  @override
  Future<User> login(body) async {
    Response response = await _baseRepository
        .executeRequest("POST", "Login/SignIn", header, body: body);
    return User.fromJson(json.decode(response.body));
  }

  @override
  Future<User> signUp(body) async {
    try {
      Response response = await _baseRepository
          .executeRequest("POST", "Login/SignUp", header, body: body);
      return User.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
