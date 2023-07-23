import 'package:dio/dio.dart';

class CustonDio {
  final _dio = Dio();

  Dio get dio => _dio;

  CustonDio() {
    _dio.options.headers["X-Parse-Application-Id"] =
        "PiyiMThNbfh0W9soRVhM1yVFJZhoXbVv1ZY384G0";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "DCJzTt6G3F5aGRtEInKiR919jwbKEqJJXCgwi94X";
    _dio.options.headers["Content-Type"] = "application/json";
  }
}
