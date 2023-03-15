import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/attendance_one_day_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_report_summary.data.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';
import 'package:flex_year_tablet/data_models/attendance_weekly_report.data.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/attendance_report.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.view.dart';
import 'package:flutter/material.dart';

class AttendanceReportModel extends ViewModel with SnackbarMixin {
  // Services
  final AttendanceService _attendanceService = locator<AttendanceService>();

  // Data
  late AttendanceReportFilterType _filterType;
  AttendanceReportFilterType get filterType => _filterType;
  late Map<String, dynamic> _searchParams;
  Map<String, dynamic> get searchParams => _searchParams;

  List<AttendanceReportData> _monthlyReport = [];
  List<AttendanceReportData> get monthlyReport => _monthlyReport;

  List<AttendanceReportSummaryData> _reportSummary = [];
  List<AttendanceReportSummaryData> get reportSummary => _reportSummary;

  List<AttendanceSummaryData> _summary = [];
  List<AttendanceSummaryData> get summary => _summary;

  List<AttendanceWeeklyReportData> _weeklyReport = [];
  List<AttendanceWeeklyReportData> get weeklyReport => _weeklyReport;

  List<AttendanceOneDayReportData> _oneDayReports = [];
  List<AttendanceOneDayReportData> get oneDayReports => _oneDayReports;

  // Actions
  Future<void> init(AttendanceReportArguments arguments) async {
    _filterType = arguments.type;
    _searchParams = arguments.searchParams;
    setIdle();

    try {
      setLoading();

      if (_filterType == AttendanceReportFilterType.monthly) {
        _monthlyReport = await _attendanceService.getMonthlyReport(
          data: _searchParams,
        );
        _reportSummary =
            await _attendanceService.getMonthlySummary(data: _searchParams);
      } else if (_filterType == AttendanceReportFilterType.daily) {
        _summary = await _attendanceService.getAttendanceSummary(
          date: _searchParams['date'],
          clientId: _searchParams['client_id'],
        );
      } else if (_filterType == AttendanceReportFilterType.weekly) {
        _weeklyReport = await _attendanceService.getWeeklyReport(
          data: _searchParams,
        );
      } else if (_filterType == AttendanceReportFilterType.oneDayReport) {
        _oneDayReports = await _attendanceService.getOneDayReport(
          data: _searchParams,
        );

        debugPrint(_oneDayReports.toString());
      }

      setSuccess();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> onFilterPressed() async {
    final response = await goto(
      AttendanceReportFilterView.tag,
      arguments: AttendanceReportFilterArguments(
        type: _filterType,
        returnBack: true,
      ),
    );

    if (response != null) {
      init(response);
    }
  }
}
