import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/data_models/company_staff.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.arguments.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.view.dart';
import 'package:flutter/material.dart';

class AddAttendanceModel extends ViewModel with SnackbarMixin, DialogMixin {
  // Services
  final AttendanceService _attendanceService = locator<AttendanceService>();

  // Data
  List<ClientData>? get clients => locator<CompanyService>().clients;
  List<String>? get clientsLabel => clients?.map((e) => e.name).toList();

  ClientData? _selectedClient;
  String? _selectedClientLabel;
  String? get selectedClientLabel => _selectedClientLabel;

  set selectedClientLabel(String? value) {
    _selectedClientLabel = value;
    _selectedClient = clients?.firstWhere((e) => e.name == value);
    setIdle();
  }

  List<CompanyStaffData> _selectedStaffs = [];
  List<CompanyStaffData> get selectedStaffs => _selectedStaffs;

  bool _isCheckInCheckOutSelected = false;
  bool get isCheckinCheckoutSelected => _isCheckInCheckOutSelected;
  set isCheckinCheckoutSelected(bool value) {
    _isCheckInCheckOutSelected = value;
    setIdle();
  }

  bool _isLunchInLunchOutSelected = false;
  bool get isLunchInLunchOutSelected => _isLunchInLunchOutSelected;
  set isLunchInLunchOutSelected(bool value) {
    _isLunchInLunchOutSelected = value;
    setIdle();
  }

  DateTime? _attendanceDate = DateTime.now();
  DateTime? get attendanceDate => _attendanceDate;
  set attendanceDate(DateTime? value) {
    _attendanceDate = value;
    setIdle();
  }

  TimeOfDay? _checkInTime;
  TimeOfDay? get checkInTime => _checkInTime;
  set checkInTime(TimeOfDay? value) {
    _checkInTime = value;
    setIdle();
  }

  TimeOfDay? _checkOutTime;
  TimeOfDay? get checkOutTime => _checkOutTime;
  set checkOutTime(TimeOfDay? value) {
    _checkOutTime = value;
    setIdle();
  }

  TimeOfDay? _lunchInTime;
  TimeOfDay? get lunchInTime => _lunchInTime;
  set lunchInTime(TimeOfDay? value) {
    _lunchInTime = value;
    setIdle();
  }

  TimeOfDay? _lunchOutTime;
  TimeOfDay? get lunchOutTime => _lunchOutTime;
  set lunchOutTime(TimeOfDay? value) {
    _lunchOutTime = value;
    setIdle();
  }

  // Actions
  Future<void> init() async {
    if (clients != null && clients!.isNotEmpty) {
      _selectedClient = clients!.first;
      _selectedClientLabel = _selectedClient!.name;
    }
    setIdle();
  }

  Future<void> onSelectStaffPressed() async {
    final _response = await goto(
      StaffsView.tag,
      arguments: StaffsArguments(
        isSelectMode: true,
        selectedStaffs: _selectedStaffs.toList(),
        preventSelf: true,
        clientId: _selectedClient?.clientId.toString(),
      ),
    );

    debugPrint(_response.toString());

    if ((_response as Set<CompanyStaffData>).isNotEmpty) {
      _selectedStaffs = _response.toList();
      setIdle();
    }
  }

  Future<void> onAddAttendancePressed() async {
    try {
      dialog.showDialog(DialogRequest(
          type: DialogType.progress, title: 'Adding attendance....'));

      _validate();

      await _attendanceService.addAttendanceToStaff(
        userIds: _selectedStaffs.map((e) => e.userId).toList(),
        clientId: _selectedClient?.clientId.toString(),
        checkInDateTime: _isCheckInCheckOutSelected
            ? '${attendanceDate!.year}-${attendanceDate!.month}-${attendanceDate!.day} ${_checkInTime!.hour}:${_checkOutTime!.minute}'
            : '',
        checkOutDateTime: _isCheckInCheckOutSelected
            ? '${attendanceDate!.year}-${attendanceDate!.month}-${attendanceDate!.day} ${_checkOutTime!.hour}:${_checkOutTime!.minute}'
            : '',
        lunchInDateTime: _isLunchInLunchOutSelected
            ? '${attendanceDate!.year}-${attendanceDate!.month}-${attendanceDate!.day} ${_lunchInTime!.hour}:${_lunchInTime!.minute}'
            : '',
        lunchOutDateTime: _isLunchInLunchOutSelected
            ? '${attendanceDate!.year}-${attendanceDate!.month}-${attendanceDate!.day} ${_lunchOutTime!.hour}:${_lunchOutTime!.minute}'
            : '',
      );

      dialog.hideDialog();
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: 'Attendance added to staffs.',
        ),
      );
      goBack();
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  void _validate() {
    if (_selectedStaffs.isEmpty) {
      throw 'Please select staffs';
    }

    if (_attendanceDate == null) {
      throw 'Please select attendance date';
    }

    if (_isCheckInCheckOutSelected) {
      if (_checkInTime == null) {
        throw 'Please select check in time';
      }

      if (_checkOutTime == null) {
        throw 'Please select check out time';
      }

      if (_checkInTime!.hour > _checkOutTime!.hour) {
        throw 'Check in time cannot be after check out time';
      }
    }

    if (_isLunchInLunchOutSelected) {
      if (_lunchInTime == null) {
        throw 'Please select lunch in time';
      }

      if (_lunchOutTime == null) {
        throw 'Please select lunch out time';
      }

      if (_lunchInTime!.hour > _lunchOutTime!.hour) {
        throw 'Lunch in time cannot be after lunch out time';
      }
    }
  }
}
