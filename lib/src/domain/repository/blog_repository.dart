import 'package:blog/src/domain/model/category.dart';

abstract class BlogRepository {
  Future<Category> getCategories(String token);
}
