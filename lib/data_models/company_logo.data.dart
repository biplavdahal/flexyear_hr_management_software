// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_logo.data.freezed.dart';
part 'company_logo.data.g.dart';

@freezed
class CompanyLogoData with _$CompanyLogoData {
  const factory CompanyLogoData({
    @JsonKey(name: 'company_logo') required String logoPath,
  }) = _CompanyLogoData;

  factory CompanyLogoData.fromJson(Map<String, dynamic> json) =>
      _$CompanyLogoDataFromJson(json);
}
