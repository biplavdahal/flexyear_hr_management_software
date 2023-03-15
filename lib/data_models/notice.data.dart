// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'notice.data.freezed.dart';
part 'notice.data.g.dart';

@freezed
class NoticeData with _$NoticeData {
  const factory NoticeData({
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "date") required String date,
    @JsonKey(name: "company_id") required int id,
  }) = _NoticeData;

  factory NoticeData.fromJson(Map<String, dynamic> json) =>
      _$NoticeDataFromJson(json);
}
