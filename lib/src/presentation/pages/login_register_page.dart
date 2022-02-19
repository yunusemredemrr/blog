// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_if_null_operators

import 'package:blog/src/application/view_model/user_view_model.dart';
import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/domain/types/enums/login_state.dart';
import 'package:blog/src/presentation/widgets/default_app_bar.dart';
import 'package:blog/src/presentation/widgets/default_button.dart';
import 'package:blog/src/presentation/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool _passwordObscureText = true;
  IconData _passwordSuffixIcon = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    EdgeInsets pading = MediaQuery.of(context).padding;
    final _userModel = Provider.of<UserViewModel>(context);
    final _userModelSet = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: InkWell(
        highlightColor: kBackGroundColor,
        focusColor: kBackGroundColor,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: Center(
          child: Column(
            children: [
              DefaultAppBar(
                leadingOnPressed: () {},
                actionOnPressed: () {},
                backgroundColor: kWhite,
                titleColor: kBlack,
                title: _userModel.loginState == LoginState.Login
                    ? "Login"
                    : "Sign Up",
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    height:
                        _userModel.loginState == LoginState.Login ? 495 : 567,
                    width: 359,
                    duration: Duration(milliseconds: 500),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 1),
                          width: 358,
                          height: 174,
                          child: SizedBox(
                            width: 176,
                            height: 176,
                            child: Image.asset("assets/images/logo.png"),
                          ),
                        ),
                        const SizedBox(height: 25),
                        AnimatedContainer(
                          curve: Curves.fastOutSlowIn,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(2, 5),
                                )
                              ]),
                          width: 359,
                          height: _userModel.loginState == LoginState.Login
                              ? 294
                              : 366,
                          duration: Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                                width: 359,
                                height:
                                    _userModel.loginState == LoginState.Login
                                        ? 134
                                        : 206,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 359,
                                      height: 62,
                                      padding: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DefaultTextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _userModel.emailController,
                                        prefixIcon: Icons.email,
                                        hintText: "Email",
                                        labelText: "Email",
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: 359,
                                      height: 62,
                                      padding: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DefaultTextField(
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: _passwordObscureText,
                                        controller:
                                            _userModel.passwordController,
                                        prefixIcon: Icons.lock,
                                        suffixIcon: _passwordSuffixIcon,
                                        suffixIconOnTap: () {
                                          changePasswordObscureText();
                                        },
                                        hintText: "Password",
                                        labelText: "Password",
                                      ),
                                    ),
                                    AnimatedContainer(
                                      margin: EdgeInsets.only(
                                        top: _userModel.loginState ==
                                                LoginState.Login
                                            ? 0
                                            : 10,
                                      ),
                                      curve: Curves.fastOutSlowIn,
                                      duration: Duration(milliseconds: 500),
                                      width: 359,
                                      height: _userModel.loginState ==
                                              LoginState.Login
                                          ? 0
                                          : 62,
                                      padding: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: _userModel.loginState ==
                                              LoginState.Register
                                          ? DefaultTextField(
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: _passwordObscureText,
                                              controller: _userModel
                                                  .rePasswordController,
                                              prefixIcon: Icons.lock,
                                              suffixIcon: _passwordSuffixIcon,
                                              suffixIconOnTap: () {
                                                changePasswordObscureText();
                                              },
                                              hintText: "Re-Password",
                                              labelText: "Re-Password",
                                            )
                                          : SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 31),
                              SizedBox(
                                height: 129,
                                width: 359,
                                child: Column(
                                  children: [
                                    DefaultButton(
                                      buttonPressed: () {
                                        _userModelSet
                                            .userAuthentication(context);
                                      },
                                      buttonText: _userModel.loginState ==
                                              LoginState.Login
                                          ? "Login"
                                          : "Register",
                                      height: 56,
                                      width: 358,
                                      textColor: kWhite,
                                      icon: Icon(Icons.login),
                                      iconColor: Colors.white,
                                    ),
                                    const SizedBox(height: 16),
                                    DefaultButton(
                                      buttonPressed: () {
                                        _userModel.loginState ==
                                                LoginState.Login
                                            ? _userModelSet.loginState =
                                                LoginState.Register
                                            : _userModelSet.loginState =
                                                LoginState.Login;
                                      },
                                      buttonText: _userModel.loginState ==
                                              LoginState.Login
                                          ? "Register"
                                          : "Login",
                                      height: 57,
                                      width: 359,
                                      butonColor: kBackGroundColor,
                                      icon: Icon(Icons.login),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48 + pading.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changePasswordObscureText() {
    setState(() {
      _passwordObscureText = !_passwordObscureText;
      _passwordSuffixIcon == Icons.visibility
          ? _passwordSuffixIcon = Icons.visibility_off
          : _passwordSuffixIcon = Icons.visibility;
    });
  }
}
