// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday.data.freezed.dart';
part 'birthday.data.g.dart';

@freezed
class BirthdayData with _$BirthdayData {
  const factory BirthdayData({
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'staff_photo') required String staffPhoto,
    @JsonKey(name: 'dob') required String dob,
  }) = _BirthdayData;

  factory BirthdayData.fromJson(Map<String, dynamic> json) =>
      _$BirthdayDataFromJson(json);
}
