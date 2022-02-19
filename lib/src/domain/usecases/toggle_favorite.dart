import 'package:blog/src/domain/model/favorite.dart';
import 'package:blog/src/domain/repository/blog_repository.dart';

class ToggleFavorite {
  final BlogRepository _repository;
  ToggleFavorite(this._repository);

  Future<Favorite> toggleFavorite(token, id) async {
    try {
      return await _repository.toggleFavorite(token, id);
    } catch (e) {
      rethrow;
    }
  }
}
