import 'dart:convert';

import 'package:bestfriend/bestfriend.dart';
import 'package:dio/dio.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/constants/prefs.constants.dart';
import 'package:flex_year_tablet/data_models/staff.data.dart';
import 'package:flex_year_tablet/data_models/user.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.model.dart';
import 'package:flutter/material.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  // Services
  final AppAccessService _appAccessService = locator<AppAccessService>();
  final ApiService _apiService = locator<ApiService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  // Properties
  UserData? _user;
  @override
  UserData? get user => _user;

  StaffData? _staffData;
  @override
  StaffData? get staffData => _staffData;

  bool _isNormalUser = false;
  @override
  bool get isNormalUser => _isNormalUser;

  @override
  Future<bool> isLoggedIn() async {
    final _pref = await _sharedPreferenceService.get<String?>(pfLoggedInUser);

    if (_pref.value != null) {
      _user = UserData.fromJson(jsonDecode(_pref.value!));
      return true;
    }

    return false;
  }

  @override
  Future<void> authByUsername({
    required String username,
    required String password,
  }) async {
    try {
      final _response = await _apiService.post(auUserLogin, {}, params: {
        'company_id': _appAccessService.appAccess!.company.companyId,
        'username': username,
        'password': password,
      });

      final data = constructResponse(_response.data);

      debugPrint(data.toString());

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }

      _user = UserData.fromJson(data);

      _sharedPreferenceService.set(pfLoggedInUser, jsonEncode(_user!.toJson()));
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<void> authByPin({required String pin}) async {
    try {
      final _response = await _apiService.post(auUserPinLogin, {}, params: {
        'company_id': _appAccessService.appAccess!.company.companyId,
        'pin': pin,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }

      _user = UserData.fromJson(data);

      _sharedPreferenceService.set(pfLoggedInUser, jsonEncode(_user!.toJson()));
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<String> requestResetPassword(
      {required String email, required int company_id}) async {
    try {
      final response =
          await _apiService.post(auRequestResetPassword, {}, params: {
        'email': email,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(response.data);

      if (!data!["status"]) {
        throw data;
      }

      return data["response"];
    } on DioError catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<String?> getSavedUsername() async {
    final _response =
        await _sharedPreferenceService.get<String?>(pfSavedUsername);
    return _response.value;
  }

  @override
  Future<void> saveUsername(String username) async {
    await _sharedPreferenceService.set<String>(pfSavedUsername, username);
  }

  @override
  Future<String?> getSavedPassword() async {
    final _response =
        await _sharedPreferenceService.get<String?>(pfSavedPassword);
    return _response.value;
  }

  @override
  Future<void> savePassword(String password) async {
    await _sharedPreferenceService.set<String>(pfSavedPassword, password);
  }

  @override
  Future<void> logout() async {
    try {
      await _apiService.post(auUserLogout, {}, params: {
        'access_token': _user!.accessToken,
      });

      _sharedPreferenceService.remove(pfLoggedInUser);

      if (locator<LeaveRequestModel>().onModelReadyCalled) {
        locator<LeaveRequestModel>().setOnModelReadyCalled(status: false);
      }
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<void> updateUser(Map<String, dynamic> data) async {
    _user = _user!.copyWith(staff: StaffData.fromJson(data));

    await _sharedPreferenceService.set<String>(
      pfLoggedInUser,
      jsonEncode(
        _user!.toJson(),
      ),
    );
    _isNormalUser = _user!.role == "staff";
  }
}
