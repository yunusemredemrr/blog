import 'package:blog/src/domain/repository/secure_storage_repository.dart';
import 'package:blog/src/domain/usecases/get_secure_value.dart';
import 'package:blog/src/domain/usecases/login_user.dart';
import 'package:blog/src/domain/usecases/set_secure_value.dart';
import 'package:blog/src/domain/usecases/sign_up_user.dart';
import 'package:blog/src/infrastructure/repository/data_secure_storage_repository.dart';
import 'package:blog/src/infrastructure/repository/data_user_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingletonAsync<LoginUser>(
      () async => LoginUser(DataUserRepository()));

  locator.registerSingletonAsync<SignUpUser>(
      () async => SignUpUser(DataUserRepository()));

  locator.registerSingletonAsync<SetSecureValue>(
      () async => SetSecureValue(DataSecureStorageRepository()));

  locator.registerSingletonAsync<GetSecureValue>(
      () async => GetSecureValue(DataSecureStorageRepository()));
}