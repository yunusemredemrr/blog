import 'package:blog/src/domain/model/validation_error.dart';

class Blog {
  List<ValidationErrors>? validationErrors;
  bool? hasError;
  String? message;
  List<BlogData>? data;

  Blog({this.validationErrors, this.hasError, this.message, this.data});

  Blog.fromJson(Map<String, dynamic> json) {
    if (json['ValidationErrors'] != null) {
      validationErrors = <ValidationErrors>[];
      json['ValidationErrors'].forEach((v) {
        validationErrors!.add(ValidationErrors.fromJson(v));
      });
    }
    hasError = json['HasError'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <BlogData>[];
      json['Data'].forEach((v) {
        data!.add(BlogData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (validationErrors != null) {
      data['ValidationErrors'] =
          validationErrors!.map((v) => v.toJson()).toList();
    }
    data['HasError'] = hasError;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlogData {
  String? title;
  String? content;
  String? image;
  String? categoryId;
  String? id;

  BlogData({this.title, this.content, this.image, this.categoryId, this.id});

  BlogData.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    content = json['Content'];
    image = json['Image'];
    categoryId = json['CategoryId'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Content'] = content;
    data['Image'] = image;
    data['CategoryId'] = categoryId;
    data['Id'] = id;
    return data;
  }
}
