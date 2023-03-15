// ignore_for_file: invalid_annotation_target

import 'package:flex_year_tablet/data_models/attendance_report_summary.data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_report.data.freezed.dart';
part 'attendance_report.data.g.dart';

@freezed
class AttendanceReportData with _$AttendanceReportData {
  const factory AttendanceReportData({
    @JsonKey(name: 'date') required String date,
    @JsonKey(name: 'in') required String checkInTime,
    @JsonKey(name: 'out') required String checkOutTime,
    @JsonKey(name: 'holiday') String? holiday,
    @JsonKey(name: 'weekend') required String weekend,
    @JsonKey(name: 'lunch_in') required String lunchIn,
    @JsonKey(name: 'lunch_out') required String lunchOut,
    @JsonKey(name: 'total_lunch') required String lunchDuration,
    @JsonKey(name: 'attendance') required String workingHours,
    @JsonKey(name: 'grand_total') required String totalWorkingHours,
  }) = _AttendanceReportData;

  factory AttendanceReportData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceReportDataFromJson(json);
}
