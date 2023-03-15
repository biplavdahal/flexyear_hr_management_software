import 'dart:convert';

import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/attendance_status.data.dart';
import 'package:flex_year_tablet/data_models/local_attendance.data.dart';
import 'package:flex_year_tablet/data_models/pin.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/tablet.service.dart';

class TabletServiceImpl implements TabletService {
  // Services
  final ApiService _apiService = locator<ApiService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();
  final SharedPreferenceService _preferenceService =
      locator<SharedPreferenceService>();

  PinData? _loggedInAs;
  @override
  PinData? get loggedInAs => _loggedInAs;
  @override
  set loggedInAs(PinData? pin) {
    _loggedInAs = pin;
  }

  final List<PinData> _pins = [];
  @override
  List<PinData> get pins => _pins;

  @override
  Future<void> loadPins() async {
    try {
      final _response = await _apiService.get(auGetPins, params: {
        'access_token': _appAccessService.apiKey,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'client_id': _appAccessService.client!.clientId,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }

      _pins.clear();

      final _pinsJson = data["pin"] as List;

      for (var pinJson in _pinsJson) {
        if (pinJson['pin'] == null) continue;
        _pins.add(PinData.fromJson(pinJson));
      }
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<AttendanceStatusData> attendanceStatus() async {
    try {
      final _response =
          await _apiService.post(auTabletAttendanceStatus, {}, params: {
        'access_token': _appAccessService.apiKey,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'client_id': _appAccessService.client!.clientId,
        'user_id': _loggedInAs!.userId,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }

      return AttendanceStatusData.fromJson(data);
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<AttendanceStatusData> postAttendanceStatus({
    required String status,
  }) async {
    try {
      final _response = await _apiService.post(auTabletPostAttendance, {
        'access_token': _appAccessService.apiKey,
        'user_id': _loggedInAs!.userId,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'client_id': _appAccessService.client!.clientId,
        'type': status,
        'datetime': getCurrentDateTime(),
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      return AttendanceStatusData.fromJson(data["data"]["data"]);
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<AttendanceStatusData> postAttedanceStatusLocally(
      {required String status}) async {
    final _today = DateTime.now();

    final _attendancesStrLocally = await _preferenceService
        .get<String?>('attendance-${formattedDate(_today.toString())}');

    if (_attendancesStrLocally.value != null) {
      final _json = jsonDecode(_attendancesStrLocally.value!) as List;

      final _attendances =
          _json.map((e) => LocalAttendanceData.fromJson(e)).toList();
      final newAttendance = LocalAttendanceData(
        companyId: _appAccessService.appAccess!.company.companyId,
        userId: _loggedInAs!.userId,
        dateTime: getCurrentDateTime(),
        type: status,
        clientId: _appAccessService.client!.clientId.toString(),
      );

      _attendances.add(newAttendance);

      await _preferenceService.set<String>(
        'attendance-${formattedDate(_today.toString())}',
        jsonEncode(_attendances),
      );
    } else {
      final _attendances = [
        LocalAttendanceData(
            companyId: _appAccessService.appAccess!.company.companyId,
            userId: _loggedInAs!.userId,
            dateTime: getCurrentDateTime(),
            type: status,
            clientId: "0")
      ];

      await _preferenceService.set<String>(
        'attendance-${formattedDate(_today.toString())}',
        jsonEncode(_attendances),
      );
    }

    if (status == 'checkin') {
      return const AttendanceStatusData(
        checkIn: 0,
        checkOut: 1,
        lunchIn: 1,
        lunchOut: 0,
        breakIn: 0,
        breakOut: 0,
      );
    } else if (status == 'checkout') {
      return const AttendanceStatusData(
        checkIn: 1,
        checkOut: 0,
        lunchIn: 0,
        lunchOut: 0,
        breakIn: 0,
        breakOut: 0,
      );
    } else if (status == 'lunchin') {
      return const AttendanceStatusData(
        checkIn: 0,
        checkOut: 0,
        lunchIn: 0,
        lunchOut: 1,
        breakIn: 0,
        breakOut: 0,
      );
    } else {
      return const AttendanceStatusData(
        checkIn: 0,
        checkOut: 1,
        lunchIn: 0,
        lunchOut: 0,
        breakIn: 0,
        breakOut: 0,
      );
    }
  }

  @override
  Future<void> syncAttendancesWithServer(List attendances) async {
    try {
      final _response = await _apiService.post(auTabletSync, {
        'access_token': _appAccessService.apiKey,
        'attendances': attendances,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }
    } catch (e) {
      throw apiError(e);
    }
  }
}
