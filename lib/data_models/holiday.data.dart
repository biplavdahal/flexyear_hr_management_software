// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'holiday.data.freezed.dart';
part 'holiday.data.g.dart';

@freezed
class HolidayData with _$HolidayData {
  const factory HolidayData({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'date') required String date,
  }) = _HolidayData;

  factory HolidayData.fromJson(Map<String, dynamic> json) =>
      _$HolidayDataFromJson(json);
}
