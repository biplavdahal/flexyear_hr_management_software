import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/attendance_correction_review.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import '../dashboard/dashboard.model.dart';

class AttendanceCorrectionModel extends ViewModel
    with SnackbarMixin, DialogMixin {
  // Services
  final AttendanceService _attendanceService = locator<AttendanceService>();
  final _user = locator<DashboardModel>().user;
  // Data
  List<String> get tabs => ['All', 'Pending', 'Approved', 'Declined'];

  String _selectedTab = "1";
  String get selectedTab => _selectedTab;

  int get id => _user.id;

  set selectedTab(String tab) {
    _selectedTab = tab;
    setIdle();
  }

  List<AttendanceCorrectionReviewData> _corrections = [];
  final _status = {"P": "1", "A": "2", "D": "3", "": "0"};
  List<AttendanceCorrectionReviewData> get correctionsToShow => _corrections
      .where(
          (correction) => _status[correction.correctionStatus] == _selectedTab)
      .toList();

  List<AttendanceCorrectionReviewData> get corrections => _corrections;

  // Actions
  Future<void> init() async {
    try {
      setLoading();

      _corrections =
          await _attendanceService.getAttendanceCorrectionReviews(id);
      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onDelete(String _attendanceId) async {
    try {
      final isConfirm = await dialog.showDialog(
        DialogRequest(
            type: DialogType.confirmation,
            title: 'Are you sure you want to delete correction request?'),
      );

      if (isConfirm?.result != null) {
        dialog.showDialog(
          DialogRequest(
              type: DialogType.progress, title: 'Removing correction request.'),
        );

        await _attendanceService.removeAttendanceCorrection(_attendanceId);

        _corrections.removeWhere((element) => element.id == _attendanceId);
        setIdle();

        dialog.hideDialog();
      }
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onApprove(String requestId) async {
    try {
      final isConfirm = await dialog.showDialog(DialogRequest(
          type: DialogType.confirmation,
          title: "Are you sure you want to approve request",
          dismissable: true));
      if (isConfirm?.result != null) {
        setWidgetBusy('$requestId-request');
        await _attendanceService.actionOnAttendanceCorrectionReview(
            attendanceId: requestId, status: "Approved");

        _corrections = _corrections.map((request) {
          if (request.id == requestId) {
            return request.copyWith(
                correctionStatus: '1', checkinDatetime: '1');
          }
          return request;
        }).toList();
      }
      init();
      unsetWidgetBusy('$requestId-request');
    } catch (e) {
      unsetWidgetBusy('$requestId-request');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onDecline(String requestId) async {
    try {
      final isConfirm = await dialog.showDialog(DialogRequest(
          title: "Are you sure you want to Decline request?",
          type: DialogType.confirmation));
      if (isConfirm?.result != null) {
        setWidgetBusy('$requestId-request');
        await _attendanceService.actionOnAttendanceCorrectionReview(
            attendanceId: requestId, status: "Declined");

        _corrections = _corrections.map((request) {
          if (request.id == requestId) {
            return request.copyWith(
                correctionStatus: '1', checkinDatetime: '1');
          }
          return request;
        }).toList();
      }
      unsetWidgetBusy('$requestId-request');

      init();
    } catch (e) {
      unsetWidgetBusy('$requestId-request');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
