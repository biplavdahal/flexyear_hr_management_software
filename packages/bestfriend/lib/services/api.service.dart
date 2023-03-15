import 'package:dio/dio.dart';

abstract class ApiService {
  /// callable to be implemented by subclasses
  void call({
    required String baseUrl,
    String contentType = 'application/json',
    Map<String, dynamic>? headers,
  });

  /// Set headers for all requests
  /// @param key
  /// @param value
  void setHeaders(String key, String value);

  /// Send [GET] request to the server and returns <T> object
  /// @param point - point to the resource
  /// @param params - optional parameters
  Future<Response> get(String point, {Map<String, dynamic>? params});

  /// Send [POST] request to the server and returns <T> object
  /// @param point - point to send request to
  /// @param body - body of the request
  /// @param params - query parameters
  Future<Response> post(String point, dynamic body,
      {Map<String, dynamic>? params, bool asFormData});

  /// Send [PUT] request to the server and returns <T> object
  /// @param point - point to send request to
  /// @param body - body of the request
  /// @param params - query parameters
  Future<Response> put(String point, dynamic body,
      {Map<String, dynamic>? params});

  /// Send [PATCH] request to the server and returns <T> object
  /// @param point - point to send request to
  /// @param body - body of the request
  /// @param params - query parameters
  Future<Response> patch(String point, dynamic body,
      {Map<String, dynamic>? params});

  /// Send [DELETE] request to the server and returns [bool]
  /// @param point - point to send request to
  /// @param params - query parameters
  /// @param body - body of the request
  Future<bool> delete(String point,
      {dynamic body, Map<String, dynamic>? params});
}
