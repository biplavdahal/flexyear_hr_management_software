// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_summary.data.freezed.dart';
part 'attendance_summary.data.g.dart';

@freezed
class AttendanceSummaryData with _$AttendanceSummaryData {
  const factory AttendanceSummaryData({
    @JsonKey(name: 'attendance_id') required String attendanceId,
    @JsonKey(name: 'status') String? statusIn,
    @JsonKey(name: 'status_out')  String? statusOut,
    @JsonKey(name: 'checkin_datetime') String? chekinDatetime,
    @JsonKey(name: 'checkout_datetime') String? checkoutDatetime,
    @JsonKey(name: 'tot_work') String? totalWorkedHour,
  }) = _AttendanceSummaryData;

  factory AttendanceSummaryData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSummaryDataFromJson(json);
}
