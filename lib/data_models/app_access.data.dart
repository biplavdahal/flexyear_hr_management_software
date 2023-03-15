// ignore_for_file: invalid_annotation_target

import 'package:flex_year_tablet/data_models/company.data.dart';
import 'package:flex_year_tablet/data_models/company_logo.data.dart';
import 'package:flex_year_tablet/data_models/timezone.data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_access.data.freezed.dart';
part 'app_access.data.g.dart';

@freezed
class AppAccessData with _$AppAccessData {
  const factory AppAccessData({
    @JsonKey(name: 'project') required String project,
    @JsonKey(name: 'comapny') required CompanyData company,
    @JsonKey(name: 'logo') required CompanyLogoData logo,
    @JsonKey(name: 'timezone') required TimezoneData timezone,
  }) = _AppAccessData;

  factory AppAccessData.fromJson(Map<String, dynamic> json) =>
      _$AppAccessDataFromJson(json);
}
