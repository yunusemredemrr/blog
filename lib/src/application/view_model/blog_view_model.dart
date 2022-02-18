// ignore_for_file: avoid_print

import 'package:blog/locator.dart';
import 'package:blog/src/domain/model/category.dart';
import 'package:blog/src/domain/types/enums/blog_view_state.dart';
import 'package:blog/src/domain/usecases/get_categories.dart';
import 'package:flutter/widgets.dart';

class BlogViewModel extends ChangeNotifier {
  BlogViewState _blogViewState = BlogViewState.Idle;
  Category? categories;

  BlogViewState get blogViewState => _blogViewState;

  set blogViewState(BlogViewState value) {
    _blogViewState = value;
    notifyListeners();
  }

  BlogViewModel(token) {
    getCategories(token);
  }

  getCategories(token) async {
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
}
