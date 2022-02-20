// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum TabItem { Favorite, Blog, Profile }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.Favorite: TabItemData("Favorite", Icons.favorite),
    TabItem.Blog: TabItemData("Home", Icons.home),
    TabItem.Profile: TabItemData("Profil", Icons.person),
  };
}
