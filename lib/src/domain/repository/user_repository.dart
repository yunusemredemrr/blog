import 'package:blog/src/domain/model/user.dart';

abstract class UserRepository {
  Future<User> login(body);
  Future<User> signUp(body);
}
