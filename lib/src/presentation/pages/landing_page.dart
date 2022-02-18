import 'package:blog/src/application/view_model/user_view_model.dart';
import 'package:blog/src/presentation/pages/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<UserViewModel>(context).curentUser;

    if (_currentUser != null) {
      return HomePage();
    } else {
      return LoginRegisterPage();
    }
  }
}
