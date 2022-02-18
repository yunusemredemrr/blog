import 'dart:convert';

import 'package:blog/src/domain/model/category.dart';
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
}
