// ignore_for_file: invalid_annotation_target

import 'package:flex_year_tablet/data_models/designation.data.dart';
import 'package:flex_year_tablet/data_models/staff_address.data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flex_year_tablet/data_models/staff.data.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/data_models/timezone.data.dart';

part 'user.data.freezed.dart';
part 'user.data.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'staff_photo') String? staffPhoto,
    // @JsonKey(name: 'access_level') required int accessLevel,
    @JsonKey(name: 'staff') required StaffData staff,
    @JsonKey(name: 'staffaddressper')
        required List<StaffAddressData> staffAddresses,
    @JsonKey(name: 'timezone') TimezoneData? timezone,
    @JsonKey(name: 'designation') DesignationData? designation,
    @JsonKey(name: 'client') required List<ClientData> clients,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
