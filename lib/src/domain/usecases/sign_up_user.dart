import 'package:blog/src/domain/model/user.dart';
import 'package:blog/src/domain/repository/user_repository.dart';

class SignUpUser {
  final UserRepository _repository;
  SignUpUser(this._repository);

  Future<User> signUp(body) async {
    try {
      return await _repository.signUp(body);
    } catch (e) {
      rethrow;
    }
  }
}
