import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/leave_request.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/leave.service.dart';
import 'package:flutter/material.dart';

class LeaveServiceImpl implements LeaveService {
  final ApiService _apiService = locator<ApiService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Future<void> createLeaveRequest(Map<String, dynamic> leaveData) async {
    try {
      final _response = await _apiService.post(auNewLeaveRequest, {
        ...leaveData,
        'user_id': _authenticationService.user!.id,
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      return;
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<List<LeaveRequestData>> getAllLeaveRequests([bool self = true]) async {
    try {
      final _response = await _apiService.post(auLeaveSearch, {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'sortnane': 'date_to',
        'sortno': 2,
        'search': {
          if (self) 'staff_id': _authenticationService.user!.id,
        }
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      if (!self) {
        return data["data"]
            .where((json) =>
                json.containsKey('staffname') && json['staffname'] != null)
            .map<LeaveRequestData>((item) => LeaveRequestData.fromJson(item))
            .where((item) =>
                item.staffId == _authenticationService.user!.id.toString())
            .toList();
      }

      return data["data"]
          .map<LeaveRequestData>((item) => LeaveRequestData.fromJson(item))
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<void> deleteLeaveRequest(String id) async {
    try {
      final _response = await _apiService.post(auRemoveLeaveRequest, {
        'access_token': _authenticationService.user!.accessToken,
        'id': id,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      return;
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<void> updateLeaveRequest(Map<String, dynamic> leaveData) async {
    try {
      final _response = await _apiService.post(auEditLeaveRequest, {
        ...leaveData,
        'user_id': _authenticationService.user!.id,
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(_response.data);

      debugPrint(data.toString());

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      return;
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<void> actionOnLeaveRequest(
      {required String requestId, required String action}) async {
    try {
      final _response = await _apiService.post(auActionOnLeaveRequest, {
        'access_token': _authenticationService.user!.accessToken,
        'id': requestId,
        'status': action,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }
    } catch (e) {
      throw apiError(e);
    }
  }
}
