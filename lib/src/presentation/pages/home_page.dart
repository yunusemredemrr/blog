// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, no_logic_in_create_state

import 'package:blog/src/application/view_model/account_view_model.dart';
import 'package:blog/src/application/view_model/blog_view_model.dart';
import 'package:blog/src/domain/model/user.dart';
import 'package:blog/src/domain/types/enums/tab_item.dart';
import 'package:blog/src/presentation/pages/blog_page.dart';
import 'package:blog/src/presentation/pages/favorite_page.dart';
import 'package:blog/src/presentation/pages/profile_page.dart';
import 'package:blog/src/presentation/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage(this._user, {Key? key}) : super(key: key);
  final User _user;

  @override
  State<HomePage> createState() => _HomePageState(_user);
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Blog;
  final User _user;
  _HomePageState(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagess(_currentTab),
      bottomNavigationBar: CustomNavigationBar(
        currentTab: _currentTab,
        blogItemFunction: () {
          setState(() {
            _currentTab = TabItem.Blog;
          });
        },
        favoriteItemFunction: () {
          setState(() {
            _currentTab = TabItem.Favorite;
          });
        },
        profileItemFunction: () {
          setState(() {
            _currentTab = TabItem.Profile;
          });
        },
      ),
    );
  }

  _pagess(TabItem item) {
    if (item == TabItem.Favorite) {
      return FavoritePage();
    } else if (item == TabItem.Blog) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => BlogViewModel(_user.data!.token.toString()),
          ),
          ChangeNotifierProvider(
            create: (_) => AccountViewModel(_user.data!.token.toString()),
          ),
        ],
        child: BlogPage(_user),
      );
    } else {
      return ProfilePage();
    }
  }
}
