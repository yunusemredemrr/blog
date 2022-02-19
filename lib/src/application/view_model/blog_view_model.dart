// ignore_for_file: avoid_print

import 'package:blog/locator.dart';
import 'package:blog/src/application/view_model/account_view_model.dart';
import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/domain/model/blog.dart';
import 'package:blog/src/domain/model/category.dart';
import 'package:blog/src/domain/model/favorite.dart';
import 'package:blog/src/domain/types/enums/banner_type.dart';
import 'package:blog/src/domain/types/enums/blog_view_state.dart';
import 'package:blog/src/domain/usecases/get_blogs.dart';
import 'package:blog/src/domain/usecases/get_categories.dart';
import 'package:blog/src/domain/usecases/toggle_favorite.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BlogViewModel extends ChangeNotifier {
  BlogViewState _blogViewState = BlogViewState.Idle;
  Category? categories;
  Blog? blogs;
  String token;

  BlogViewState get blogViewState => _blogViewState;

  set blogViewState(BlogViewState value) {
    _blogViewState = value;
    notifyListeners();
  }

  BlogViewModel(this.token) {
    blogViewState = BlogViewState.Idle;
    getCategories();
    getBlogs();
  }

  getCategories() async {
    try {
      blogViewState = BlogViewState.Bussy;
      Category _currentCategories =
          await locator.get<GetCategories>().getCategories(token);
      if (!_currentCategories.hasError!) {
        categories = _currentCategories;
      }
    } catch (e) {
      print(e);
    } finally {
      blogViewState = BlogViewState.Loaded;
    }
  }

  void getBlogs({categoryId}) async {
    try {
      blogViewState = BlogViewState.Bussy;
      Blog _currentBlogs =
          await locator.get<GetBlogs>().getBlogs(token, categoryId: categoryId);
      if (!_currentBlogs.hasError!) {
        print(_currentBlogs.data!.length);
        blogs = _currentBlogs;
      }
    } catch (e) {
      print(e);
    } finally {
      blogViewState = BlogViewState.Loaded;
    }
  }

  void toggleFavorite(id, BuildContext context) async {
    try {
      blogViewState = BlogViewState.Bussy;
      Favorite _currentFavorite =
          await locator.get<ToggleFavorite>().toggleFavorite(token, id);
      if (!_currentFavorite.hasError!) {
        kShowBanner(BannerType.SUCCESS, _currentFavorite.message!, context);
        Provider.of<AccountViewModel>(context, listen: false).getAccount();
      } else {
        kShowBanner(BannerType.ERROR, "Sorry", context);
      }
    } catch (e) {
      print(e);
    } finally {
      blogViewState = BlogViewState.Loaded;
    }
  }
}
