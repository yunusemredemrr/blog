// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, prefer_const_constructors_in_immutables, unused_field

import 'package:blog/src/application/view_model/account_view_model.dart';
import 'package:blog/src/application/view_model/blog_view_model.dart';
import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/domain/model/account.dart';
import 'package:blog/src/domain/model/user.dart';
import 'package:blog/src/presentation/widgets/category_container.dart';
import 'package:blog/src/presentation/widgets/default_app_bar.dart';
import 'package:flutter/cupertino.dart';
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
    AccountViewModel _accountViewModel = Provider.of<AccountViewModel>(context);

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
            height: 114,
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
                        height: 93,
                        width: 166,
                        categoryTitle: _blogViewModel
                            .categories!.data![key].title
                            .toString(),
                        categoryImage: _blogViewModel
                            .categories!.data![key].image
                            .toString(),
                        onTap: () {
                          Provider.of<BlogViewModel>(context, listen: false)
                              .getBlogs(
                            categoryId: _blogViewModel.categories!.data![key].id
                                .toString(),
                          );
                        },
                      ),
                ],
              ),
            ),
          ),
          SizedBox(height: 31),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Blog",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 17),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Wrap(
                runSpacing: 14,
                children: [
                  if (_blogViewModel.blogs != null)
                    for (int key = 0;
                        key < _blogViewModel.blogs!.data!.length;
                        key++)
                      Stack(
                        children: [
                          CategoryContainer(
                            width: 176,
                            height: 267,
                            categoryTitle: _blogViewModel
                                .blogs!.data![key].title
                                .toString(),
                            categoryImage: _blogViewModel
                                .blogs!.data![key].image
                                .toString(),
                            onTap: () {},
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<BlogViewModel>(context,
                                        listen: false)
                                    .toggleFavorite(
                                        _blogViewModel.blogs!.data![key].id,
                                        context);
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Icon(
                                Icons.favorite,
                                size: 30,
                                color: favoriteIconColor(
                                    _blogViewModel.blogs!.data![key].id),
                              ),
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color favoriteIconColor(id) {
    Account? _account = Provider.of<AccountViewModel>(context).account;
    if (_account != null) {
      for (var key = 0; key < _account.data!.favoriteBlogIds!.length; key++) {
        if (_account.data!.favoriteBlogIds![key] == id) {
          return kErrorTextColor;
        }
      }
      return kWhite;
    } else {
      return kWhite;
    }
  }
}
