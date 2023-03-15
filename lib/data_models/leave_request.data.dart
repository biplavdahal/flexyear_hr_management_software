// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_request.data.freezed.dart';
part 'leave_request.data.g.dart';

@freezed
class LeaveRequestData with _$LeaveRequestData {
  const factory LeaveRequestData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'staff_id') required String staffId,
    @JsonKey(name: 'date_to') required String dateTo,
    @JsonKey(name: 'date_from') required String dateFrom,
    @JsonKey(name: 'description') required String reason,
    @JsonKey(name: 'is_approved') required String status,
    @JsonKey(name: 'no_of_days') required String numberOfDays,
    @JsonKey(name: 'hour') String? totalHours,
    @JsonKey(name: 'leave_type') required String leaveType,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'from_time') String? fromTime,
    @JsonKey(name: 'to_time') String? toTime,
    @JsonKey(name: 'requested_date') required String requestedDate,
    @JsonKey(name: 'staffname') required String staffName,
    @JsonKey(name: 'checked_by') required String checkedBy,
  }) = _LeaveRequestData;

  factory LeaveRequestData.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestDataFromJson(json);
}
