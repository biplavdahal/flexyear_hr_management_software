// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_status.data.freezed.dart';
part 'attendance_status.data.g.dart';

@freezed
class AttendanceStatusData with _$AttendanceStatusData {
  const factory AttendanceStatusData({
    @JsonKey(name: 'checkin') required int checkIn,
    @JsonKey(name: 'lunchin') required int lunchIn,
    @JsonKey(name: 'lunchout') required int lunchOut,
    @JsonKey(name: 'checkout') required int checkOut,
    @JsonKey(name: 'breakin') required int breakIn,
    @JsonKey(name: 'breakout') required int breakOut,
  }) = _AttendanceStatusData;

  factory AttendanceStatusData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceStatusDataFromJson(json);
}
