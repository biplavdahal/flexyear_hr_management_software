// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'client.data.freezed.dart';
part 'client.data.g.dart';

@freezed
class ClientData with _$ClientData {
  const factory ClientData({
    @JsonKey(name: 'client_id') required String clientId,
    @JsonKey(name: 'company_id') required String companyId,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'address') required String address,
  }) = _ClientData;

  factory ClientData.fromJson(Map<String, dynamic> json) =>
      _$ClientDataFromJson(json);
}
