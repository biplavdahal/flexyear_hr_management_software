import 'package:flex_year_tablet/data_models/attendance_correction.data.dart';
import 'package:flex_year_tablet/data_models/attendance_correction_review.data.dart';
import 'package:flex_year_tablet/data_models/attendance_forgot.data.dart';
import 'package:flex_year_tablet/data_models/attendance_one_day_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_report_summary.data.dart';
import 'package:flex_year_tablet/data_models/attendance_status.data.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';
import 'package:flex_year_tablet/data_models/attendance_weekly_report.data.dart';

abstract class AttendanceService {
  /// Get attendance status for dashboard
  Future<AttendanceStatusData> getAttendanceStatus({
    String? clientId,
  });

  /// Get attendance forgotten status
  Future<AttendanceForgotData?> getAttendanceForgot();

  /// Post attendance status
  Future<AttendanceStatusData> postAttendanceStatus({
    required String time,
    String? clientId,
    required String status,
  });

  /// Get monthly report
  ///
  /// Goto [AttendanceReportFilterModel] to see what [data] holds
  Future<List<AttendanceReportData>> getMonthlyReport({
    required Map<String, dynamic> data,
  });

  Future<List<AttendanceReportSummaryData>> getMonthlySummary({
        required Map<String, dynamic> data,
        });

  /// Get attendance summary
  Future<List<AttendanceSummaryData>> getAttendanceSummary({
    required String date,
    String? clientId,
    String? staffId,
  });

  // Get weekly report
  Future<List<AttendanceWeeklyReportData>> getWeeklyReport({
    required Map<String, dynamic> data,
  });

  /// Get list of attendance corrections
  Future<List<AttendanceCorrectionData>> getAttendanceCorrections();

  /// Post forget checkout review
  Future<void> postForgetCheckoutReview({
    required String attendanceId,
    required String dateTime,
    String? message,
  });

  /// Remove attendance correction
  Future<void> removeAttendanceCorrection(String attendanceId);

  /// Post attendance correction
  Future<void> addAttendanceCorrection({
    required String attendanceId,
    required String inDateTime,
    required String outDateTime,
    String? message,
  });

  /// Edit attendance correction
  Future<void> editAttendanceCorrection({
    required String attendanceId,
    required String inDateTime,
    required String outDateTime,
    String? message,
  });

  /// Get one day report
  Future<List<AttendanceOneDayReportData>> getOneDayReport({
    required Map<String, dynamic> data,
  });

  /// Get all attendance correction reviews
  Future<List<AttendanceCorrectionReviewData>> getAttendanceCorrectionReviews(
      int id);

  /// Approve or decline attendance review
  Future<void> actionOnAttendanceCorrectionReview({
    required String attendanceId,
    required String status, // 0 pending, 1 approve, 2 decline
  });

  /// Add attendance to staff
  Future<void> addAttendanceToStaff({
    String checkInDateTime = '',
    String checkOutDateTime = '',
    String lunchInDateTime = '',
    String lunchOutDateTime = '',
    required List<String> userIds,
    String? clientId,
  });
}
