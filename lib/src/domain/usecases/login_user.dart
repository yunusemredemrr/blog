import 'package:blog/src/domain/model/user.dart';
import 'package:blog/src/domain/repository/user_repository.dart';

class LoginUser {
  final UserRepository _repository;
  LoginUser(this._repository);

  Future<User> login(body) async {
    try {
      return await _repository.login(body);
    } catch (e) {
      rethrow;
    }
  }
}
