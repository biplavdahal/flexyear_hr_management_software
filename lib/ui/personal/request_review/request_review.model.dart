import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/attendance_correction.data.dart';
import 'package:flex_year_tablet/data_models/attendance_correction_review.data.dart';
import 'package:flex_year_tablet/data_models/attendance_forgot.data.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.arguments.dart';
import 'package:flutter/material.dart';

enum RequestReviewType {
  updateReview,
  attendanceReview,
  checkoutReview,
}

class RequestReviewModel extends ViewModel with SnackbarMixin, DialogMixin {
  // Service
  final AttendanceService _attendanceService = locator<AttendanceService>();

  // Data
  late RequestReviewType _requestReviewType;
  RequestReviewType get requestReviewType => _requestReviewType;

  TimeOfDay? _inTime;
  TimeOfDay? get inTime => _inTime;
  set inTime(TimeOfDay? value) {
    _inTime = value;
    setIdle();
  }

  TimeOfDay? _outTime;
  TimeOfDay? get outTime => _outTime;
  set outTime(TimeOfDay? value) {
    _outTime = value;
    setIdle();
  }

  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  late String _attendanceId;
  late AttendanceSummaryData _summary;
  late AttendanceForgotData _attendanceForgot;
  late AttendanceCorrectionReviewData _attendanceCorrection;

  // Action
  Future<void> init(RequestReviewArguments arguments) async {
    _requestReviewType = arguments.type;

    if (_requestReviewType == RequestReviewType.attendanceReview) {
      _summary = arguments.payload as AttendanceSummaryData;

      _inTime = stringTimeToTimeOfDay(_summary.chekinDatetime!);
      _outTime = stringTimeToTimeOfDay(_summary.checkoutDatetime!);
      _attendanceId = _summary.attendanceId;
    } else if (_requestReviewType == RequestReviewType.updateReview) {
      _attendanceCorrection =
          arguments.payload as AttendanceCorrectionReviewData;

      _inTime =
          stringTimeToTimeOfDay(_attendanceCorrection.checkinDatetimeRequest!);
      _outTime =
          stringTimeToTimeOfDay(_attendanceCorrection.checkoutDatetimeRequest!);
      _attendanceId = _attendanceCorrection.id;
    } else if (_requestReviewType == RequestReviewType.checkoutReview) {
      _attendanceForgot = arguments.payload as AttendanceForgotData;

      _attendanceId = _attendanceForgot.attendanceId.toString();
    }
    setIdle();
  }

  Future<void> onSubmit() async {
    try {
      dialog.showDialog(
          DialogRequest(type: DialogType.progress, title: "Sending Request"));

      if (_requestReviewType == RequestReviewType.checkoutReview) {
        if (outTime == null) {
          throw "Please select checkout time";
        }

        await _attendanceService.postForgetCheckoutReview(
          attendanceId: _attendanceId,
          dateTime:
              '${_attendanceForgot.forgottonDate} ${_outTime!.hour}:${_outTime!.minute}',
          message: _messageController.text,
        );
        snackbar.displaySnackbar(
          SnackbarRequest.of(message: "Checkout Request Sent!"),
        );
      } else if (_requestReviewType == RequestReviewType.attendanceReview) {
        if (inTime == null || outTime == null) {
          throw "Please select checkin and checkout time";
        }

        await _attendanceService.addAttendanceCorrection(
          attendanceId: _attendanceId,
          inDateTime:
              '${_summary.chekinDatetime!.split(" ")[0]} ${_inTime!.hour}:${_inTime!.minute}',
          outDateTime:
              '${_summary.checkoutDatetime!.split(" ")[0]} ${_outTime!.hour}:${_outTime!.minute}',
          message: _messageController.text,
        );
        snackbar.displaySnackbar(
          SnackbarRequest.of(message: "Correction Request Sent!"),
        );
      } else if (_requestReviewType == RequestReviewType.updateReview) {
        if (inTime == null || outTime == null) {
          throw "Please select checkin and checkout time";
        }

        await _attendanceService.editAttendanceCorrection(
          attendanceId: _attendanceId,
          inDateTime:
              '${_attendanceCorrection.checkinDatetime!.split(" ")[0]} ${_inTime!.hour}:${_inTime!.minute}',
          outDateTime:
              '${_attendanceCorrection.checkinDatetime!.split(" ")[0]} ${_outTime!.hour}:${_outTime!.minute}',
          message: _messageController.text,
        );

        snackbar.displaySnackbar(
          SnackbarRequest.of(message: "Correction Updated Sent!"),
        );
      }

      dialog.hideDialog();
      goBack(result: true);
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}