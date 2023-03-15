// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_weekly_report.data.freezed.dart';
part 'attendance_weekly_report.data.g.dart';

@freezed
class AttendanceWeeklyReportData with _$AttendanceWeeklyReportData {
  const factory AttendanceWeeklyReportData({
    @JsonKey(name: 'sunday') required String sunday,
    @JsonKey(name: 'monday') required String monday,
    @JsonKey(name: 'tuesday') required String tuesday,
    @JsonKey(name: 'wednesday') required String wednesday,
    @JsonKey(name: 'thursday') required String thursday,
    @JsonKey(name: 'friday') required String friday,
    @JsonKey(name: 'saturday') required String saturday,
    @JsonKey(name: 'workinghr') required String totalWorkingHr,
    @JsonKey(name: 'name') required String name,
  }) = _AttendanceWeeklyReportData;

  factory AttendanceWeeklyReportData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceWeeklyReportDataFromJson(json);
}
