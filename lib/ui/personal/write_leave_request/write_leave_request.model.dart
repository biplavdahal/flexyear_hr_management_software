import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/get_userstaff.data.dart';
import 'package:flex_year_tablet/data_models/leave_type.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/services/leave.service.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.arguments.dart';
import 'package:flutter/material.dart';

class WriteLeaveRequestModel extends ViewModel with DialogMixin, SnackbarMixin {
  // Services
  final LeaveService _leaveService = locator<LeaveService>();

  // UI Controllers and keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  // Data

  late UserStaffData _selectedUserStaffType;
  UserStaffData get selectedUserStaffType => _selectedUserStaffType;
  String? _selectedUserStafflabel;
  String? get selectedUserStaffLevel => _selectedUserStafflabel;

  List<LeaveTypeData> get leaveTypes => locator<CompanyService>().leaveTypes!;
  List<String> get leaveTypeLabels => leaveTypes.map((e) => e.title).toList();

  late LeaveTypeData _selectedLeaveType;
  LeaveTypeData get selectedLeaveType => _selectedLeaveType;

  String? _selectedLeaveTypeLabel;
  String? get selectedLeaveTypeLabel => _selectedLeaveTypeLabel;

  DateTime? _leaveDateFrom;
  DateTime? get leaveDateFrom => _leaveDateFrom;
  set leaveDateFrom(DateTime? value) {
    _leaveDateFrom = value;
    setIdle();
  }

  DateTime? _leaveDateUpto;
  DateTime? get leaveDateUpto => _leaveDateUpto;
  set leaveDateUpto(DateTime? value) {
    _leaveDateUpto = value;
    setIdle();
  }


  String _currentDateTime = DateTime.now().toString();
  String get currentDateTime => _currentDateTime;

  bool _isHalfDayLeave = false;
  bool get isHalfDayLeave => _isHalfDayLeave;
  set isHalfDayLeave(bool value) {
    _isHalfDayLeave = value;
    setIdle();
  }

  TimeOfDay? _leaveTimeFrom;
  TimeOfDay? get leaveTimeFrom => _leaveTimeFrom;
  set leaveTimeFrom(TimeOfDay? value) {
    _leaveTimeFrom = value;
    setIdle();
  }

  TimeOfDay? _leaveTimeUpto;
  TimeOfDay? get leaveTimeUpto => _leaveTimeUpto;
  set leaveTimeUpto(TimeOfDay? value) {
    _leaveTimeUpto = value;
    setIdle();
  }

  final TextEditingController _leaveDescriptionController =
      TextEditingController();
  TextEditingController get leaveDescriptionController =>
      _leaveDescriptionController;

  bool _isEditMode = false;
  String? _requestId;

  // Actions

  void init(WriteLeaveRequestViewArguments? arguments) {
    if (arguments?.request != null) {
      _isEditMode = true;
      _requestId = arguments!.request!.id;
      _selectedLeaveType = leaveTypes.firstWhere(
        (e) => e.id.toString() == arguments.request!.leaveType,
      );
      _selectedLeaveTypeLabel = _selectedLeaveType.title;
      _leaveDateFrom = DateTime.parse(arguments.request!.dateFrom);
      _leaveDateUpto = DateTime.parse(arguments.request!.dateTo);
      _isHalfDayLeave =
          arguments.request!.totalHours != "00:00:00" ? true : false;
      if (_isHalfDayLeave) {
        _leaveTimeFrom = TimeOfDay(
          hour: int.parse(arguments.request!.fromTime!.split(":")[0]),
          minute: int.parse(arguments.request!.fromTime!.split(":")[1]),
        );
        _leaveTimeUpto = TimeOfDay(
          hour: int.parse(arguments.request!.toTime!.split(":")[0]),
          minute: int.parse(arguments.request!.toTime!.split(":")[1]),
        );
      }

      _leaveDescriptionController.text = arguments.request!.reason;
    } else {
      _selectedLeaveType = leaveTypes.first;
      _selectedLeaveTypeLabel = _selectedLeaveType.title;
    }
    setIdle();
  }

  void onLeaveTypeChanged(String? label) {
    _selectedLeaveType = leaveTypes.firstWhere((e) => e.title == label);
    _selectedLeaveTypeLabel = label;
    setIdle();
  }

  // void onUserTypeChanged(String? label) {
  //   _selectedUserStaffType =
  //       userStaffTypes.firstWhere((e) => e.firstName == label);
  //   _selectedUserStafflabel = label;
  // }

  Future<void> onSubmitRequestPressed() async {
    _validateFields();

    try {
      dialog.showDialog(
        DialogRequest(
            type: DialogType.progress,
            title: '${_isEditMode ? 'Updating' : 'Creating'} leave request...'),
      );

      if (_isEditMode) {
        await _leaveService.updateLeaveRequest(prepareDate());
      } else {
        await _leaveService.createLeaveRequest(prepareDate());
      }

      dialog.hideDialog();
      goBack(result: true);
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  void _validateFields() {
    if (_leaveDateFrom == null) {
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: 'Please select leave date from',
        ),
      );
      return;
    }

    if (_leaveDateUpto == null) {
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: 'Please select leave date upto',
        ),
      );
      return;
    }

    if (_leaveDateFrom!.isAfter(_leaveDateUpto!)) {
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: 'Leave date "from" cannot be after leave date "upto"',
        ),
      );
      return;
    }

    if (_isHalfDayLeave && _leaveTimeFrom == null) {
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: 'Please select leave time from',
        ),
      );
      return;
    }

    if (_isHalfDayLeave && _leaveTimeUpto == null) {
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: 'Please select leave time upto',
        ),
      );
      return;
    }

    if (_isHalfDayLeave && _leaveTimeFrom!.hour > _leaveTimeUpto!.hour) {
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: 'Leave time "from" cannot be after leave time "upto"',
        ),
      );
      return;
    }
  }

  Map<String, dynamic> prepareDate() {
    Map<String, dynamic> data = {};

    data['date_from'] =
        "${_leaveDateFrom!.year}-${_leaveDateFrom!.month}-${_leaveDateFrom!.day}";
    data['date_to'] =
        "${_leaveDateUpto!.year}-${_leaveDateUpto!.month}-${_leaveDateUpto!.day}";
    data['leave_type'] = _selectedLeaveType.id.toString();
    data['description'] = _leaveDescriptionController.text.trim();
    data['is_half_day'] = _isHalfDayLeave ? 1 : 0;

    if (_isHalfDayLeave) {
      data['from_time'] = "${_leaveTimeFrom!.hour}:${_leaveTimeFrom!.minute}";
      data['to_time'] = "${_leaveTimeUpto!.hour}:${_leaveTimeUpto!.minute}";
    }

    if (_isEditMode) {
      data['id'] = _requestId;
    }

    return data;
  }
}
