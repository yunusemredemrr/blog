import 'package:blog/src/domain/model/account.dart';
import 'package:blog/src/domain/model/image_model.dart';
import 'package:blog/src/domain/model/update.dart';

abstract class AccountRepository {
  Future<Account> getAccount(token);
  Future<Update> updateAccount(token, body);
  Future<ImageModel> uploadImage(token, body);
}
