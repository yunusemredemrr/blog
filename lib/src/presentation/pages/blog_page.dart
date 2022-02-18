// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, prefer_const_constructors_in_immutables, unused_field

import 'package:blog/src/application/view_model/blog_view_model.dart';
import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/domain/model/user.dart';
import 'package:blog/src/presentation/widgets/category_container.dart';
import 'package:blog/src/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatefulWidget {
  final User _user;
  BlogPage(this._user, {Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState(_user);
}

class _BlogPageState extends State<BlogPage> {
  final User _user;
  _BlogPageState(this._user);

  @override
  Widget build(BuildContext context) {
    BlogViewModel _blogViewModel = Provider.of<BlogViewModel>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(
            leadingOnPressed: () {},
            actionOnPressed: () {},
            backgroundColor: kBackGroundColor,
            leadingIcon: Image.asset("assets/icons/pan.png"),
            titleColor: kBlack,
            title: "Home",
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: size.width,
            height: 174,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(
                  parent: const BouncingScrollPhysics()),
              child: Row(
                children: [
                  if (_blogViewModel.categories != null)
                    for (int key = 0;
                        key < _blogViewModel.categories!.data!.length;
                        key++)
                      CategoryContainer(
                        categoryTitle: _blogViewModel
                            .categories!.data![key].title
                            .toString(),
                        categoryImage: _blogViewModel
                            .categories!.data![key].image
                            .toString(),
                        onTap: () {},
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
