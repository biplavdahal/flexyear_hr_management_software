import 'dart:async';

import 'package:flex_year_tablet/data_models/chat_contact.data.dart';
import 'package:flex_year_tablet/data_models/chat_message.data.dart';

abstract class ChatService {
  /// Get contacts list
  Future<List<ChatContactData>> getContacts();

  StreamController<List<ChatMessageData>> get messagesStreamController;

  /// Stream messages
  Future<List<ChatMessageData>> messages(int receiverId, int senderId);

  /// Stop stream
  void stopMessageStream();

  /// Send message
  Future<ChatMessageData> sendMessage({
    required int receiverId,
    required int senderId,
    required String message,
  });
}
