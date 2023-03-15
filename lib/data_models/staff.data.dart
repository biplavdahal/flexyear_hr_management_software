// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff.data.freezed.dart';
part 'staff.data.g.dart';

@freezed
class StaffData with _$StaffData {
  const factory StaffData({
    @JsonKey(name: 'staff_id') required int staffId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'middle_name') required String middleName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'staff_photo') String? staffPhoto,
    @JsonKey(name: 'mobile') required String mobile,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'email_address') required String email,
    @JsonKey(name: 'gender') required String gender,
    @JsonKey(name: 'marital_status') String? maritalStatus,
    @JsonKey(name: 'hire_date') String? hireDate,
    @JsonKey(name: 'emp_id') required String empId,
    @JsonKey(name: 'dob') String? dob,
  }) = _StaffData;

  factory StaffData.fromJson(Map<String, dynamic> json) =>
      _$StaffDataFromJson(json);
}
