// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_staff.data.freezed.dart';
part 'company_staff.data.g.dart';

@freezed
class CompanyStaffData with _$CompanyStaffData {
  const factory CompanyStaffData({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'company_id') required String companyId,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'staff_id') required String staffId,
  }) = _CompanyStaffData;

  factory CompanyStaffData.fromJson(Map<String, dynamic> json) =>
      _$CompanyStaffDataFromJson(json);
}
