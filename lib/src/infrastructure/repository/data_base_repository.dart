// ignore_for_file: avoid_print

import 'package:blog/src/domain/repository/base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DataBaseRepository implements BaseRepository {
  static final DataBaseRepository _instance = DataBaseRepository._internal();
  DataBaseRepository._internal();
  factory DataBaseRepository() => _instance;

  String baseUrl = "http://test020.internative.net/";

  @override
  Future<Response> executeRequest(String requestType, String path, header,
      {body, isMultipar = false}) async {
    Response response;
    var url = Uri.parse(baseUrl + path);

    try {
      if (!isMultipar) {
        switch (requestType) {
          case "GET":
            response = await http.get(url, headers: header);
            break;
          case "POST":
            response = await http.post(
              url,
              headers: header,
              body: body,
            );
            break;
          case "PUT":
            response = await http.put(
              url,
              headers: header,
              body: body,
            );
            break;
          case "DELETE":
            response = await http.delete(
              url,
              headers: header,
              body: body,
            );
            break;
          default:
            throw Exception("You did not enter the request type");
        }
      } else {
        try {
          MultipartRequest _request = http.MultipartRequest("POST", url);
          MultipartFile _multipartFile =
              await http.MultipartFile.fromPath('file', body);
          _request.files.add(_multipartFile);
          StreamedResponse streamedResponse = await _request.send();
          response = await Response.fromStream(streamedResponse);
        } catch (e) {
          rethrow;
        }
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
