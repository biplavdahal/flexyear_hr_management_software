import 'dart:async';
import 'dart:convert';

import 'package:bestfriend/bestfriend.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flex_year_tablet/data_models/attendance_status.data.dart';
import 'package:flex_year_tablet/data_models/pin.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/tablet.service.dart';

class AttendanceModel extends ViewModel with SnackbarMixin, DialogMixin {
  // Services
  final TabletService _tabletService = locator<TabletService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  // Data
  PinData get loggedInAs => _tabletService.loggedInAs!;

  late AttendanceStatusData _attendanceStatus;
  AttendanceStatusData get attendanceStatus => _attendanceStatus;

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  // Actions
  Future<void> init() async {
    try {
      setLoading();

      final _connectivityResult = await Connectivity().checkConnectivity();

      if (_connectivityResult == ConnectivityResult.none) {
        _isOnline = false;
        final _userAttStatusLocally =
            await _sharedPreferenceService.get<String?>(
          'attendance-status-${loggedInAs.userId}',
        );

        if (_userAttStatusLocally.value != null) {
          _attendanceStatus = AttendanceStatusData.fromJson(
            jsonDecode(_userAttStatusLocally.value!),
          );
        } else {
          _attendanceStatus = const AttendanceStatusData(
            checkIn: 1,
            checkOut: 0,
            breakIn: 0,
            breakOut: 0,
            lunchIn: 0,
            lunchOut: 0,
          );

          await _sharedPreferenceService.set<String>(
            'attendance-status-${loggedInAs.userId}',
            jsonEncode(_attendanceStatus),
          );
        }
      } else {
        _isOnline = true;
        _attendanceStatus = await _tabletService.attendanceStatus();
      }

      setIdle();

      Connectivity().onConnectivityChanged.listen((result) {
        if (result == ConnectivityResult.none) {
          _isOnline = false;
        } else {
          _isOnline = true;
        }
        setIdle();
      });

      if (loggedInAs.accessLevel != '1') {
        Timer(const Duration(seconds: 15), () {
          goBack();
          snackbar.displaySnackbar(
            SnackbarRequest.of(message: 'Session expired!'),
          );
        });
      }
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
      goBack();
    }
  }

  Future<void> onAttendanceButtonPressed(String status) async {
    try {
      dialog.showDialog(
        DialogRequest(
            type: DialogType.progress, title: "Action in progress..."),
      );

      if (_isOnline) {
        _attendanceStatus = await _tabletService.postAttendanceStatus(
          status: status,
        );
      } else {
        _attendanceStatus = await _tabletService.postAttedanceStatusLocally(
          status: status,
        );
        await _sharedPreferenceService.set<String>(
          'attendance-status-${loggedInAs.userId}',
          jsonEncode(_attendanceStatus),
        );
      }

      dialog.hideDialog();
      setIdle();
      goBack();
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onSyncAttendancePressed() async {
    dialog.showDialog(
      DialogRequest(type: DialogType.progress, title: 'Syncing data....'),
    );

    final _localSavedAttendance = await _sharedPreferenceService.get<String?>(
      'attendance-${formattedDate(DateTime.now().toString())}',
    );

    if (_localSavedAttendance.value != null) {
      final attendances = jsonDecode(_localSavedAttendance.value!);
      await _tabletService.syncAttendancesWithServer(attendances);
      snackbar.displaySnackbar(
        SnackbarRequest.of(message: 'All attendances are synced!'),
      );
      await _sharedPreferenceService.remove(
        'attendance-${formattedDate(DateTime.now().toString())}',
      );
    } else {
      snackbar.displaySnackbar(SnackbarRequest.of(message: 'No data to sync'));
    }

    dialog.hideDialog();
  }
}
