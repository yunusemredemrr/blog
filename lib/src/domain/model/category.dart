import 'package:blog/src/domain/model/validation_error.dart';

class Category {
  List<ValidationErrors>? validationErrors;
  bool? hasError;
  String? message;
  List<Data>? data;

  Category({this.validationErrors, this.hasError, this.message, this.data});

  Category.fromJson(Map<String, dynamic> json) {
    if (json['ValidationErrors'] != null) {
      validationErrors = <ValidationErrors>[];
      json['ValidationErrors'].forEach((v) {
        validationErrors!.add(ValidationErrors.fromJson(v));
      });
    }
    hasError = json['HasError'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? title;
  String? image;
  String? id;

  Data({this.title, this.image, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    image = json['Image'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Image'] = image;
    data['Id'] = id;
    return data;
  }
}
