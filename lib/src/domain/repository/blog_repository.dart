import 'package:blog/src/domain/model/blog.dart';
import 'package:blog/src/domain/model/category.dart';
import 'package:blog/src/domain/model/favorite.dart';

abstract class BlogRepository {
  Future<Category> getCategories(String token);
  Future<Blog> getBlogs(String token, {categoryID});
  Future<Favorite> toggleFavorite(String token, String id);
}
