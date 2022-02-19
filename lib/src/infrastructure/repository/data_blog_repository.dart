import 'dart:convert';

import 'package:blog/src/domain/model/blog.dart';
import 'package:blog/src/domain/model/category.dart';
import 'package:blog/src/domain/model/favorite.dart';
import 'package:blog/src/domain/repository/base_repository.dart';
import 'package:blog/src/domain/repository/blog_repository.dart';
import 'package:blog/src/infrastructure/repository/data_base_repository.dart';
import 'package:http/http.dart';

class DataBlogRepository implements BlogRepository {
  static final _instance = DataBlogRepository._internal();
  DataBlogRepository._internal() : _baseRepository = DataBaseRepository();
  factory DataBlogRepository() => _instance;
  final BaseRepository _baseRepository;

  @override
  Future<Category> getCategories(String token) async {
    Map<String, String> header = {
      "Access-Control_Allow_Origin": "*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    Response response = await _baseRepository.executeRequest(
        "GET", "Blog/GetCategories", header);
    return Category.fromJson(json.decode(response.body));
  }

  @override
  Future<Blog> getBlogs(String token, {categoryID}) async {
    Map<String, String> header = {
      "Access-Control_Allow_Origin": "*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    dynamic body;
    if (categoryID != null) {
      body = jsonEncode({
        "CategoryId": "$categoryID",
      });
    } else {
      body = jsonEncode({"CategoryId": ""});
    }
    Response response = await _baseRepository
        .executeRequest("POST", "Blog/GetBlogs", header, body: body);
    return Blog.fromJson(json.decode(response.body));
  }

  @override
  Future<Favorite> toggleFavorite(String token, String id) async {
    Map<String, String> header = {
      "Access-Control_Allow_Origin": "*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    dynamic body = jsonEncode({
      "Id": id,
    });

    Response response = await _baseRepository
        .executeRequest("POST", "Blog/ToggleFavorite", header, body: body);
    return Favorite.fromJson(json.decode(response.body));
  }
}
