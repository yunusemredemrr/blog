// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/domain/types/enums/tab_item.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final TabItem currentTab;
  final Function favoriteItemFunction, blogItemFunction, profileItemFunction;
  CustomNavigationBar({
    required this.currentTab,
    required this.favoriteItemFunction,
    required this.blogItemFunction,
    required this.profileItemFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 55, top: 12, left: 70, right: 70),
      decoration: BoxDecoration(
        color: kBackGroundColor,
        boxShadow: [
          BoxShadow(
            color: kGrey,
            blurRadius: 4,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              favoriteItemFunction();
            },
            child: Icon(
              Icons.favorite,
              size: 24,
              color: currentTab == TabItem.Favorite ? kButtonColor : kGrey,
            ),
          ),
          GestureDetector(
            onTap: () {
              blogItemFunction();
            },
            child: Icon(
              Icons.home,
              size: 24,
              color: currentTab == TabItem.Blog ? kButtonColor : kGrey,
            ),
          ),
          GestureDetector(
            onTap: () {
              profileItemFunction();
            },
            child: Icon(
              Icons.person,
              size: 24,
              color: currentTab == TabItem.Profile ? kButtonColor : kGrey,
            ),
          ),
        ],
      ),
    );
  }
}
