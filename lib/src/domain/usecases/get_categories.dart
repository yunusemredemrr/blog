import 'package:blog/src/domain/model/category.dart';
import 'package:blog/src/domain/repository/blog_repository.dart';

class GetCategories {
  final BlogRepository _repository;
  GetCategories(this._repository);

  Future<Category> getCategories(token) async {
    try {
      return await _repository.getCategories(token);
    } catch (e) {
      rethrow;
    }
  }
}
