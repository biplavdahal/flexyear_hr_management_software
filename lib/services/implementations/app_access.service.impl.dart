import 'dart:convert';

import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/constants/prefs.constants.dart';
import 'package:flex_year_tablet/data_models/app_access.data.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flutter/material.dart';

class AppAccessServiceImplementation implements AppAccessService {
  final ApiService _apiService = locator<ApiService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  AppAccessData? _appAccessData;
  @override
  AppAccessData? get appAccess => _appAccessData;

  ClientData? _client;
  @override
  ClientData? get client => _client;

  String? _appUsage;
  @override
  String? get appUsage => _appUsage;
  @override
  set appUsage(String? value) {
    _appUsage = value;

    if (value != null) {
      _sharedPreferenceService.set<String>(pfAppUsageType, value);
    }
  }

  @override
  String? get apiKey => "fe37a9b05d21502e483350beae61b0e7d00b6b49";

  @override
  Future<void> init() async {
    final appAccessDataStr =
        await _sharedPreferenceService.get<String?>(pfAccessData);
    final appUsageStr =
        await _sharedPreferenceService.get<String?>(pfAppUsageType);
    final appClientStr =
        await _sharedPreferenceService.get<String?>(pfClientData);

    if (appAccessDataStr.value == null) {
      return;
    }
    _appAccessData = AppAccessData.fromJson(
      jsonDecode(appAccessDataStr.value!),
    );

    if (appUsageStr.value == null) {
      return;
    }
    _appUsage = appUsageStr.value;

    if (appClientStr.value == null) {
      return;
    }
    _client = ClientData.fromJson(
      jsonDecode(appClientStr.value!),
    );
  }

  @override
  Future<void> getAppAccess(String token) async {
    try {
      final _response = await _apiService.get(auAppAccess, params: {
        'token': token,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }

      _appAccessData = AppAccessData.fromJson(data);

      await _sharedPreferenceService.set<String>(
        pfAccessData,
        jsonEncode(_appAccessData),
      );
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<void> getClientAccess(String code) async {
    try {
      final _response = await _apiService.get(auAppAccessClientCode, params: {
        'client_code': code,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }
      debugPrint(data.toString());

      _client = ClientData.fromJson({
        ...data['data'],
        'client_id': data['data']['client_id'].toString(),
        'company_id': data['data']['company_id'].toString(),
      });

      debugPrint(_client.toString());

      await _sharedPreferenceService.set<String>(
        pfClientData,
        jsonEncode(_client),
      );
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<void> clearData() async {
    await _sharedPreferenceService.remove(pfAccessData);
    await _sharedPreferenceService.remove(pfClientData);
    await _sharedPreferenceService.remove(pfAppUsageType);
    await _sharedPreferenceService.remove(pfLoggedInUser);
    await _sharedPreferenceService.remove(pfSavedUsername);
  }
}
