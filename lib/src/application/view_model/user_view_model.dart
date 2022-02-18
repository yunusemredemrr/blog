// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:blog/locator.dart';
import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/domain/model/user.dart';
import 'package:blog/src/domain/types/enums/banner_type.dart';
import 'package:blog/src/domain/types/enums/login_state.dart';
import 'package:blog/src/domain/types/enums/view_state.dart';
import 'package:blog/src/domain/usecases/get_secure_value.dart';
import 'package:blog/src/domain/usecases/login_user.dart';
import 'package:blog/src/domain/usecases/set_secure_value.dart';
import 'package:blog/src/domain/usecases/sign_up_user.dart';
import 'package:flutter/widgets.dart';

class UserViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  LoginState _loginState = LoginState.Login;
  User? _curentUser;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  String? emailErrorMessage = "";

  ViewState get viewState => _viewState;
  LoginState get loginState => _loginState;
  User? get curentUser => _curentUser;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get rePasswordController => _rePasswordController;

  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  UserViewModel() {
    currentUser();
  }

  set loginState(LoginState value) {
    _loginState = value;
    notifyListeners();
  }

  userAuthentication(BuildContext context) {
    if (loginState == LoginState.Login) {
      userLogin(context);
    } else {
      userSignUp(context);
    }
  }

  userLogin(BuildContext context) async {
    try {
      viewState = ViewState.Busy;
      if (_emailController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty) {
        String body = jsonEncode({
          "Email": _emailController.text.trim(),
          "Password": _passwordController.text.trim()
        });
        User user = await locator.get<LoginUser>().login(body);
        if (user.hasError!) {
          kShowBanner(BannerType.ERROR, user.message!.toString(), context);
          if (user.validationErrors!.isNotEmpty) {
            kShowBanner(BannerType.ERROR,
                user.validationErrors!.first.value.toString(), context);
          }
        } else {
          _curentUser = user;
          await locator
              .get<SetSecureValue>()
              .write(_curentUser!.data!.token.toString());
        }
      }
    } catch (e, st) {
      print(e);
      print(st);
      kShowBanner(BannerType.ERROR, e.toString(), context);
    } finally {
      viewState = ViewState.Idle;
    }
  }

  userSignUp(BuildContext context) async {
    try {
      viewState = ViewState.Busy;
      if ((_emailController.text.trim().isNotEmpty &&
              _passwordController.text.trim().isNotEmpty &&
              _rePasswordController.text.trim().isNotEmpty) &&
          _passwordController.text.trim() ==
              _rePasswordController.text.trim()) {
        String body = jsonEncode({
          "Email": _emailController.text.trim(),
          "Password": _passwordController.text.trim(),
          "PasswordRetry": _rePasswordController.text.trim()
        });
        User user = await locator.get<SignUpUser>().signUp(body);
        if (user.hasError!) {
          kShowBanner(BannerType.ERROR, user.message!.toString(), context);
          if (user.validationErrors!.isNotEmpty) {
            kShowBanner(BannerType.ERROR,
                user.validationErrors!.first.value.toString(), context);
          }
        } else {
          _curentUser = user;
          await locator
              .get<SetSecureValue>()
              .write(_curentUser!.data!.token.toString());
        }
      } else if ((_emailController.text.trim().isNotEmpty &&
              _passwordController.text.trim().isNotEmpty &&
              _rePasswordController.text.trim().isNotEmpty) &&
          _passwordController.text.trim() !=
              _rePasswordController.text.trim()) {
        kShowBanner(BannerType.ERROR, "Girilen Şifreler Uyuşmuyor", context);
      }
    } catch (e, st) {
      print(e);
      print(st);
      kShowBanner(BannerType.ERROR, e.toString(), context);
    } finally {
      viewState = ViewState.Idle;
    }
  }

  currentUser() async {
    try {
      viewState = ViewState.Busy;
      Map<String, String> token = await locator.get<GetSecureValue>().readAll();

      if (token.isNotEmpty) {
        _curentUser = User(
            data: Data(token: token.values.first.toString()), hasError: false);
        return token.values.first;
      }
    } catch (e) {
      print(e);
    } finally {
      viewState = ViewState.Idle;
    }
  }
}
