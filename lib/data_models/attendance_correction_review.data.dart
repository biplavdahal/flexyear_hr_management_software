// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_correction_review.data.freezed.dart';
part 'attendance_correction_review.data.g.dart';

@freezed
class AttendanceCorrectionReviewData with _$AttendanceCorrectionReviewData {
  const factory AttendanceCorrectionReviewData({
    @JsonKey(name: 'attendance_id') required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'status') String? statusIn,
    @JsonKey(name: 'status_out') String? statusOut,
    @JsonKey(name: 'checkin_datetime') String? checkinDatetime,
    @JsonKey(name: 'checkout_datetime') String? checkoutDatetime,
    @JsonKey(name: 'checkin_datetime_request') String? checkinDatetimeRequest,
    @JsonKey(name: 'checkout_datetime_request') String? checkoutDatetimeRequest,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'correction_status') required String correctionStatus,
  }) = _AttendanceCorrectionReviewData;

  factory AttendanceCorrectionReviewData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCorrectionReviewDataFromJson(json);
}
