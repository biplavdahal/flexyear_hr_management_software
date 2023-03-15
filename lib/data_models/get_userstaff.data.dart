// ignore_for_file: invalid_annotation_target
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_userstaff.data.freezed.dart';
part 'get_userstaff.data.g.dart';

@freezed
class UserStaffData with _$UserStaffData {
  const factory UserStaffData(
      {@JsonKey(name: 'first_name') required String firstName,
      @JsonKey(name: 'middle_name') required String middleName,
      @JsonKey(name: 'last_name') required String lastName,
      @JsonKey(name: 'title') required  String title,
      }) = _UserStaffData;
      

  factory UserStaffData.fromJson(Map<String, dynamic> json) =>
      _$UserStaffDataFromJson(json);
}
