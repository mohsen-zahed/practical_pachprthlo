import 'package:dio/dio.dart';

class MyDioPackage {
  static MyDioPackage? _instance;
  MyDioPackage._();
  static MyDioPackage get instance {
    _instance ??= MyDioPackage._();
    return _instance!;
  }

  Future<Response> getData<T>(String url, {Map<String, dynamic>? queryParameters}) async {
    final Dio dio = Dio();
    final response = await dio.get('https://rickandmortyapi.com/api/character/?', queryParameters: queryParameters);
    print((response.data['results'] as List).length);
    return response;
  }
}
