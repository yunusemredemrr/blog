// ignore_for_file: prefer_const_constructors

import 'package:blog/locator.dart';
import 'package:blog/src/application/view_model/user_view_model.dart';
import 'package:blog/src/presentation/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => UserViewModel(),
        child: LandingPage(),
      ),
    );
  }
}
