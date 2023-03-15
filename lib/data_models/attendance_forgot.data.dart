// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_forgot.data.freezed.dart';
part 'attendance_forgot.data.g.dart';

@freezed
class AttendanceForgotData with _$AttendanceForgotData {
  const factory AttendanceForgotData({
    @JsonKey(name: 'attendance_id') required int attendanceId,
    @JsonKey(name: 'forgotton_date') required String forgottonDate,
  }) = _AttendanceForgotData;

  factory AttendanceForgotData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceForgotDataFromJson(json);
}
