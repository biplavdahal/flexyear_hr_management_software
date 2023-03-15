// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'company.data.freezed.dart';
part 'company.data.g.dart';

@freezed
class CompanyData with _$CompanyData {
  const factory CompanyData({
    @JsonKey(name: 'company_id') required int companyId,
    @JsonKey(name: 'company_name') required String companyName,
    @JsonKey(name: 'address') required String address,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'phone') required String phone,
    @JsonKey(name: 'remarks') required String remarks,
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'subdomain') required String subdomain,
  }) = _CompanyData;

  factory CompanyData.fromJson(Map<String, dynamic> json) =>
      _$CompanyDataFromJson(json);
}
