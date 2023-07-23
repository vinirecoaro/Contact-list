import 'package:dio/dio.dart';

class CustonDioBack4App {
  final _dio = Dio();

  Dio get dio => _dio;

  CustonDioBack4App() {
    _dio.options.headers["X-Parse-Application-Id"] =
        "dKWz560sEmzsPS9YJfD7ZR4C1v5WU6w2LarwrxL9";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "E6GpMhm6TsDtu3DgW3jtT5PbuPBwALFM2AwPIk1E";
    _dio.options.headers["Content-Type"] = "application/json";
  }
}
