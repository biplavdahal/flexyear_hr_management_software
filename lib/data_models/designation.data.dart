// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'designation.data.freezed.dart';
part 'designation.data.g.dart';

@freezed
class DesignationData with _$DesignationData {
  const factory DesignationData({
    @JsonKey(name: 'designation_name') required String name,
  }) = _DesignationData;

  factory DesignationData.fromJson(Map<String, dynamic> json) =>
      _$DesignationDataFromJson(json);
}
