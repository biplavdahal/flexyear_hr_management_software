// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_contact.data.freezed.dart';
part 'chat_contact.data.g.dart';

@freezed
class ChatContactData with _$ChatContactData {
  const factory ChatContactData({
    @JsonKey(name: 'acc_message_id') required String accMessageId,
    @JsonKey(name: 'to') required String to,
    @JsonKey(name: 'from') required String from,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
  }) = _ChatContactData;

  factory ChatContactData.fromJson(Map<String, dynamic> json) =>
      _$ChatContactDataFromJson(json);
}
