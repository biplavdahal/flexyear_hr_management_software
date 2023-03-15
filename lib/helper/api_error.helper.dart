import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String apiError(Object e) {
  if (e is DioError) {
    if (e.response != null) {
      if (e.response!.data is Map<String, dynamic>) {
        return e.response?.data['response'];
      }
    }
    debugPrint(e.requestOptions.baseUrl);
  } else if (e is String) {
    return e;
  }
  debugPrint(e.toString());

  return "Something unexpected occured!";
}
