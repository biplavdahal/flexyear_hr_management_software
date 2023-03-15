// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin.data.freezed.dart';
part 'pin.data.g.dart';

@freezed
class PinData with _$PinData {
  const factory PinData({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'pin') required String pin,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'emp_id') required String empId,
    @JsonKey(name: 'staff_id') required String staffId,
    @JsonKey(name: 'access_level') required String accessLevel,
  }) = _PinData;

  factory PinData.fromJson(Map<String, dynamic> json) =>
      _$PinDataFromJson(json);
}
