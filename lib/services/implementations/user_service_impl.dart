import 'package:bestfriend/bestfriend.dart';
import 'package:dio/dio.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/error_data.dart';
import 'package:flex_year_tablet/data_models/staff.data.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/user_service.dart';
import 'package:flutter/material.dart';
import '../../helper/api_error.helper.dart';
import '../../helper/api_response.helper.dart';
import '../app_access.service.dart';

class UserServiceImplementation implements UserService {
  //services
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final ApiService _apiService = locator<ApiService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();
  @override
  Future<void> changePassword({
    required String oldPassword,
    required String verifyPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.post(auChangePassword, {
        "access_token": _authenticationService.user!.accessToken,
        "user_id": _authenticationService.user!.id,
        "old_password": oldPassword,
        "password": newPassword,
        "verify_password": verifyPassword,
      });
      final data = constructResponse(response.data);
      if (data!["status"] is bool) {
        if (data["status"] == true) {
          return;
        } else {
          throw Error();
        }
      }
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
   Future<void> updateProfile(StaffData data) async {
    try {
      final response = await _apiService.post(auUpdateProfile, {
        "access_token": _authenticationService.user!.accessToken,
        "id": _authenticationService.user!.id,
        "staff_photo": _authenticationService.user!.staffPhoto,
        ...data.toJson(),
      });

      final responseData = constructResponse(response.data);

      if (responseData!["status"] is bool) {
        if (responseData["status"]) {
          _authenticationService.updateUser(responseData["response"]);
          return;
        }
      }
    } on DioError catch (e) {
      throw apiError(e);
    }
  }
}
