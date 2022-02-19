import 'package:blog/src/domain/model/validation_error.dart';

class Update {
  List<ValidationErrors>? validationErrors;
  bool? hasError;
  String? message;
  bool? data;

  Update({this.validationErrors, this.hasError, this.message, this.data});

  Update.fromJson(Map<String, dynamic> json) {
    if (json['ValidationErrors'] != null) {
      validationErrors = <ValidationErrors>[];
      json['ValidationErrors'].forEach((v) {
        validationErrors!.add(ValidationErrors.fromJson(v));
      });
    }
    hasError = json['HasError'];
    message = json['Message'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (validationErrors != null) {
      data['ValidationErrors'] =
          validationErrors!.map((v) => v.toJson()).toList();
    }
    data['HasError'] = hasError;
    data['Message'] = message;
    data['Data'] = this.data;
    return data;
  }
}
