import 'dart:convert';

import 'package:bestfriend/di.dart';
import 'package:bestfriend/enums/snack_bar_type.enum.dart';
import 'package:bestfriend/managers/snack_bar/snack_bar.service.dart';
import 'package:bestfriend/managers/snack_bar/snack_bar_request.model.dart';
import 'package:dio/dio.dart';
import 'package:flex_year_tablet/data_models/error_data.dart';
import 'package:flutter/material.dart';

import '../ui/personal/dashboard/dashboard.model.dart';

ErrorData dioError(DioError e) {
  late Map<String, dynamic> data;

  if (e.response != null) {
    if ((e.response!.data as Map<String, dynamic>).containsKey('stack-trace')) {
      data = {
        "response": "Something unexpected occured from server side.",
      };
    } else {
      data = jsonDecode(e.response!.data);

      if (!data.containsKey("response")) {
        data.putIfAbsent("response", () => data["message"]);
      }
    }
  } else {
    debugPrint("e: ${e.response?.data}");
    data = {
      "response":
          "Could not talk to server at this time. Check your internet connection and try again later!",
    };
  }
  return ErrorData.fromJson(data);
}
Map<String, dynamic>? constructResponse(dynamic data) {
  Map<String, dynamic>? constructedResponse;

  if (data is String) {
    constructedResponse = jsonDecode(data);
  } else if (data is Map) {
    constructedResponse = data as Map<String, dynamic>;
  }

  return constructedResponse;
}
void errorHandler(
  SnackbarService snackbar, {
  required ErrorData e,
}) {
  if (e.response == "Invalid Access Token") {
    locator<DashboardModel>().moreActions("logout");
    return;
  }

  snackbar.displaySnackbar(
    SnackbarRequest.of(
      message: e.response,
      type: ESnackbarType.error,
      duration: ESnackbarDuration.long,
    ),
  );
}
