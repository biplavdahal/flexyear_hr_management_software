import 'package:bestfriend/bestfriend.dart';
import 'package:dio/dio.dart';
import 'package:flex_year_tablet/data_models/leave_request.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/leave.service.dart';
import 'package:flutter/material.dart';

import '../write_leave_request/write_leave_request.arguments.dart';
import '../write_leave_request/write_leave_request.view.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';

class LeaveRequestReceivedModel extends ViewModel
    with SnackbarMixin, DialogMixin {
  // Services
  final LeaveService _leaveService = locator<LeaveService>();

  // Data
  List<LeaveRequestData> _requests = [];
  List<LeaveRequestData> get requests => _requests;
  List<LeaveRequestData> get requestsToShow =>
      _requests.where((request) => request.status == _selectedTab).toList();
  List<String> get tabs => ['Pending', 'Approved', 'Rejected', 'All'];

  String _selectedTab = "0";
  String get selectedTab => _selectedTab;

  set selectedTab(String tab) {
    _selectedTab = tab;
    setIdle();
  }

  // Action
  Future<void> init() async {
    try {
      setLoading();
      _requests = await _leaveService.getAllLeaveRequests();
      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onApprove(String requestId) async {
    try {
      setWidgetBusy('$requestId-request');
      await _leaveService.actionOnLeaveRequest(
          requestId: requestId, action: "1");

      // update correction status of review from reviews where id == attendanceId
      _requests = _requests.map((request) {
        if (request.id == requestId) {
          return request.copyWith(status: '1', checkedBy: '1');
        }

        return request;
      }).toList();
      unsetWidgetBusy('$requestId-request');
    } catch (e) {
      unsetWidgetBusy('$requestId-request');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onDecline(String requestId) async {
    try {
      setWidgetBusy('$requestId-request');
      await _leaveService.actionOnLeaveRequest(
          requestId: requestId, action: "2");

      // update correction status of review from reviews where id == attendanceId
      _requests = _requests.map((request) {
        if (request.id == requestId) {
          return request.copyWith(status: '0', checkedBy: '0');
        }

        return request;
      }).toList();
      unsetWidgetBusy('$requestId-request');
    } catch (e) {
      unsetWidgetBusy('$requestId-request');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onUpdatePressed(LeaveRequestData request) async {
    final response = await goto(WriteLeaveRequestView.tag,
        arguments: WriteLeaveRequestViewArguments(request));
    if (response != null) {
      init();
    }
  }

  Future<void> delete(LeaveRequestData data) async {
    try {
      final isConfirm = await dialog.showDialog(DialogRequest(
        type: DialogType.confirmation,
        title:
            "Are you sure you want to delete leave request of ${data.staffName}?",
        dismissable: true,
      ));
      if (isConfirm?.result != null) {
        setWidgetBusy('delete-${data.id}');

        await _leaveService.deleteLeaveRequest(data.id);
        _requests.removeWhere((request) => request.id == data);
        unsetWidgetBusy("$data-request");
      }
      init();

      Fluttertoast.showToast(
          msg:
              'Leave request of ${data.staffName} having reason ${data.reason} deleted successfully.');
    } catch (e) {
      unsetWidgetBusy("$data-request");
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
