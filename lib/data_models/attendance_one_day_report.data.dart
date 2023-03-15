// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_one_day_report.data.freezed.dart';
part 'attendance_one_day_report.data.g.dart';

@freezed
class AttendanceOneDayReportData with _$AttendanceOneDayReportData {
  const factory AttendanceOneDayReportData({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'staff_id') required int staffId,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'date') required String date,
    @JsonKey(name: 'time_in') required String timeIn,
    @JsonKey(name: 'time_out') required String timeOut,
    @JsonKey(name: 'lunch_in') required String lunchBreak,
    @JsonKey(name: 'lunch_out') required String lunchBreakOut,
    @JsonKey(name: 'total_time') required String totalTime,
    @JsonKey(name: 'lunch_time') required String lunchTime,
    @JsonKey(name: 'grand_total') required String grandTotal,
  }) = _AttendanceOneDayReportData;

  factory AttendanceOneDayReportData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceOneDayReportDataFromJson(json);
}
