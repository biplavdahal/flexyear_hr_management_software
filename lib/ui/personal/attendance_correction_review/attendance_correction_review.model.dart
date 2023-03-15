import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/attendance_correction_review.data.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';

class AttendanceCorrectionReviewModel extends ViewModel with SnackbarMixin {
  // Services
  final AttendanceService _attendanceService = locator<AttendanceService>();

  // Data
  List<AttendanceCorrectionReviewData> _reviews = [];
  List<AttendanceCorrectionReviewData> get reviews => _reviews;

  // Actions
  Future<void> init() async {
    try {
      setLoading();
      _reviews = await _attendanceService.getAttendanceCorrectionReviews(1);
      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onApprove(String attendanceId) async {
    try {
      setWidgetBusy('$attendanceId-review');
      await _attendanceService.actionOnAttendanceCorrectionReview(
          attendanceId: attendanceId, status: 'Approved');

      // update correction status of review from reviews where id == attendanceId
      _reviews = _reviews.map((review) {
        if (review.id == attendanceId) {
          return review.copyWith(correctionStatus: 'A');
        }

        return review;
      }).toList();
      unsetWidgetBusy('$attendanceId-review');
    } catch (e) {
      unsetWidgetBusy('$attendanceId-review');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onDecline(String attendanceId) async {
    try {
      setWidgetBusy('$attendanceId-review');
      await _attendanceService.actionOnAttendanceCorrectionReview(
          attendanceId: attendanceId, status: 'Declined');

      // update correction status of review from reviews where id == attendanceId
      _reviews = _reviews.map((review) {
        if (review.id == attendanceId) {
          return review.copyWith(correctionStatus: 'D');
        }

        return review;
      }).toList();
      unsetWidgetBusy('$attendanceId-review');
    } catch (e) {
      unsetWidgetBusy('$attendanceId-review');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
