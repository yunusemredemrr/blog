import 'package:blog/src/domain/model/blog.dart';
import 'package:blog/src/domain/model/category.dart';
import 'package:blog/src/domain/model/update.dart';

abstract class BlogRepository {
  Future<Category> getCategories(String token);
  Future<Blog> getBlogs(String token, {categoryID});
  Future<Update> toggleFavorite(String token, String id);
}
