// ignore_for_file: prefer_const_constructors

import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/domain/model/blog.dart';
import 'package:blog/src/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetailPage extends StatelessWidget {
  final BlogData _blog;

  const BlogDetailPage(this._blog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(
            leadingOnPressed: () {
              Navigator.pop(context);
            },
            actionOnPressed: () {},
            leadingIcon: Icon(
              Icons.arrow_back_ios,
              color: kButtonColor,
              size: 15,
            ),
            actionIcon: Icon(
              Icons.favorite,
              color: kButtonColor,
              size: 15,
            ),
            backgroundColor: kBackGroundColor,
            titleColor: kButtonColor,
            title: "Article Detail",
          ),
          SizedBox(height: 15),
          Container(
            width: size.width,
            height: size.height - 106,
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: const BouncingScrollPhysics()),
              child: Column(
                children: [
                  Text(
                    _blog.title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: kButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Html(data: _blog.content),
                  SizedBox(height: 15),
                  Image.network(_blog.image!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
