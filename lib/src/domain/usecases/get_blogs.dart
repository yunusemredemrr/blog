import 'package:blog/src/domain/model/blog.dart';
import 'package:blog/src/domain/repository/blog_repository.dart';

class GetBlogs {
  final BlogRepository _repository;
  GetBlogs(this._repository);

  Future<Blog> getBlogs(token, {categoryId}) async {
    try {
      return await _repository.getBlogs(token, categoryID: categoryId);
    } catch (e) {
      rethrow;
    }
  }
}
