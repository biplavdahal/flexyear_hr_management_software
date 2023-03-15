// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_report_summary.data.freezed.dart';
part 'attendance_report_summary.data.g.dart';

@freezed
class AttendanceReportSummaryData with _$AttendanceReportSummaryData {
  const factory AttendanceReportSummaryData({
    @JsonKey(name: 'full_name')  String? fullName,
    @JsonKey(name: 'total')  String? total,
    @JsonKey(name: 'leavetot') int? leaveTotal,
    @JsonKey(name: 'present')  int? present,
    @JsonKey(name: 'offday')  int? offDay,
    @JsonKey(name: 'totaldays')  int? totalDays,
    @JsonKey(name: 'absent')  int? absent,
    @JsonKey(name: 'workinghr') String? workingHours,
    @JsonKey(name: 'workingdays')  int? workingdays,
  }) = _AttendanceReportSummaryData;

  factory AttendanceReportSummaryData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceReportSummaryDataFromJson(json);
}
