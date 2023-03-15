// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_type.data.freezed.dart';
part 'leave_type.data.g.dart';

@freezed
class LeaveTypeData with _$LeaveTypeData {
  const factory LeaveTypeData({
    @JsonKey(name: 'leave_type_id') required int id,
    @JsonKey(name: 'title') required String title,
  }) = _LeaveTypeData;

  factory LeaveTypeData.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeDataFromJson(json);
}
