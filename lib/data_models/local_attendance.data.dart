// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_attendance.data.freezed.dart';
part 'local_attendance.data.g.dart';

@freezed
class LocalAttendanceData with _$LocalAttendanceData {
  const factory LocalAttendanceData({
    @JsonKey(name: 'company_id') required int companyId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'datetime') required String dateTime,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'client_id') required String clientId,
  }) = _LocalAttendanceData;

  factory LocalAttendanceData.fromJson(Map<String, dynamic> json) =>
      _$LocalAttendanceDataFromJson(json);
}
