// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'timezone.data.freezed.dart';
part 'timezone.data.g.dart';

@freezed
class TimezoneData with _$TimezoneData {
  const factory TimezoneData({
    @JsonKey(name: 'value') required String value,
  }) = _TimezoneData;

  factory TimezoneData.fromJson(Map<String, dynamic> json) =>
      _$TimezoneDataFromJson(json);
}
