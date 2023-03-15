import 'package:bestfriend/bestfriend.dart';
import 'package:dio/dio.dart';

class ApiServiceImplementation implements ApiService {
  late Dio _dio;

  @override
  void call({
    required String baseUrl,
    String contentType = 'application/json',
    Map<String, dynamic>? headers,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: contentType,
        headers: headers,
      ),
    );
  }

  @override
  void setHeaders(String key, String value) {
    if (_dio.options.headers.containsKey(key)) {
      _dio.options.headers[key] = value;
    } else {
      _dio.options.headers.putIfAbsent(key, () => value);
    }
  }

  @override
  Future<Response> get(String point, {Map<String, dynamic>? params}) {
    try {
      return _dio.get(
        point,
        queryParameters: params,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> put(String point, dynamic body,
      {Map<String, dynamic>? params}) {
    try {
      return _dio.put(
        point,
        data: body,
        queryParameters: params,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(String point,
      {dynamic body, Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.delete(
        point,
        data: body,
        queryParameters: params,
      );
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> patch(String point, body, {Map<String, dynamic>? params}) {
    try {
      return _dio.patch(
        point,
        data: body,
        queryParameters: params,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> post(String point, body,
      {Map<String, dynamic>? params, bool asFormData = false}) {
    try {
      return _dio.post(
        point,
        data: asFormData ? FormData.fromMap(body) : body,
        queryParameters: params,
      );
    } catch (e) {
      rethrow;
    }
  }
}
