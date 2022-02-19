import 'package:blog/src/domain/model/update.dart';
import 'package:blog/src/domain/repository/blog_repository.dart';

class ToggleFavorite {
  final BlogRepository _repository;
  ToggleFavorite(this._repository);

  Future<Update> toggleFavorite(token, id) async {
    try {
      return await _repository.toggleFavorite(token, id);
    } catch (e) {
      rethrow;
    }
  }
}
