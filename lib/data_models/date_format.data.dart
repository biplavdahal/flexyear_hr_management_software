// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_format.data.freezed.dart';
part 'date_format.data.g.dart';

@freezed
class DateFormatData with _$DateFormatData {
  const factory DateFormatData({
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'value') required String value,
  }) = _DateFormatData;

  factory DateFormatData.fromJson(Map<String, dynamic> json) =>
      _$DateFormatDataFromJson(json);
}
