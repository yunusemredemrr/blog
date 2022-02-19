import 'package:blog/src/application/view_model/user_view_model.dart';
import 'package:blog/src/presentation/pages/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    a();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<UserViewModel>(context).curentUser;

    if (_currentUser != null) {
      return HomePage(_currentUser);
    } else {
      return LoginRegisterPage();
    }
  }

  void a() async {
    await Permission.location.request();
  }
}
