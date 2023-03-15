// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_address.data.freezed.dart';
part 'staff_address.data.g.dart';

@freezed
class StaffAddressData with _$StaffAddressData {
  const factory StaffAddressData({
    @JsonKey(name: 'state') required String state,
    @JsonKey(name: 'address_line1') required String addressLine1,
    @JsonKey(name: 'address_line2') required String addressLine2,
    @JsonKey(name: 'city') required String city,
    @JsonKey(name: 'zip_code') required String zipCode,
    @JsonKey(name: 'country_name') required String country,
  }) = _StaffAddressData;

  factory StaffAddressData.fromJson(Map<String, dynamic> json) =>
      _$StaffAddressDataFromJson(json);
}
