import 'package:blog/src/domain/model/validation_error.dart';

class Account {
  List<ValidationErrors>? validationErrors;
  bool? hasError;
  String? message;
  Data? data;

  Account({this.validationErrors, this.hasError, this.message, this.data});

  Account.fromJson(Map<String, dynamic> json) {
    if (json['ValidationErrors'] != null) {
      validationErrors = <ValidationErrors>[];
      json['ValidationErrors'].forEach((v) {
        validationErrors!.add(ValidationErrors.fromJson(v));
      });
    }
    hasError = json['HasError'];
    message = json['Message'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
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
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? email;
  String? image;
  Location? location;
  List<String>? favoriteBlogIds;

  Data({this.id, this.email, this.image, this.location, this.favoriteBlogIds});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    email = json['Email'];
    image = json['Image'];
    location =
        json['Location'] != null ? Location.fromJson(json['Location']) : null;
    favoriteBlogIds = json['FavoriteBlogIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Email'] = email;
    data['Image'] = image;
    if (location != null) {
      data['Location'] = location!.toJson();
    }
    data['FavoriteBlogIds'] = favoriteBlogIds;
    return data;
  }
}

class Location {
  String? longtitude;
  String? latitude;

  Location({this.longtitude, this.latitude});

  Location.fromJson(Map<String, dynamic> json) {
    longtitude = json['Longtitude'];
    latitude = json['Latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Longtitude'] = longtitude;
    data['Latitude'] = latitude;
    return data;
  }
}
