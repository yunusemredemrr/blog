// ignore_for_file: prefer_const_constructors

import 'package:blog/src/application/view_model/account_view_model.dart';
import 'package:blog/src/application/view_model/blog_view_model.dart';
import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/presentation/pages/blog_detail_page.dart';
import 'package:blog/src/presentation/widgets/category_container.dart';
import 'package:blog/src/presentation/widgets/default_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlogViewModel _blogViewModel = Provider.of<BlogViewModel>(context);
    AccountViewModel _accountViewModel = Provider.of<AccountViewModel>(context);
    bool _myFavorites(blogId) {
      if (_accountViewModel.account != null) {
        for (var key = 0;
            key < _accountViewModel.account!.data!.favoriteBlogIds!.length;
            key++) {
          if (_accountViewModel.account!.data!.favoriteBlogIds![key] ==
              blogId) {
            return true;
          }
        }
        return false;
      } else {
        return false;
      }
    }

    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(
            leadingOnPressed: () {},
            actionOnPressed: () {},
            backgroundColor: kBackGroundColor,
            titleColor: kBlack,
            title: "My Favorites",
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Wrap(
                runSpacing: 14,
                children: [
                  if (_blogViewModel.allBlogs != null)
                    for (int key = 0;
                        key < _blogViewModel.allBlogs!.data!.length;
                        key++)
                      if (_myFavorites(_blogViewModel.allBlogs!.data![key].id))
                        Stack(
                          children: [
                            CategoryContainer(
                              width: 176,
                              height: 267,
                              categoryTitle: _blogViewModel
                                  .allBlogs!.data![key].title
                                  .toString(),
                              categoryImage: _blogViewModel
                                  .allBlogs!.data![key].image
                                  .toString(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => BlogDetailPage(
                                        _blogViewModel.allBlogs!.data![key]),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<BlogViewModel>(context,
                                          listen: false)
                                      .toggleFavorite(
                                          _blogViewModel
                                              .allBlogs!.data![key].id,
                                          context);
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: kErrorTextColor,
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
}
