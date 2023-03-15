import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/chat_contact.data.dart';
import 'package:flex_year_tablet/data_models/chat_message.data.dart';
import 'package:flex_year_tablet/services/chat.service.dart';
import 'package:flex_year_tablet/ui/personal/chats/chats.argument.dart';
import 'package:flutter/material.dart';

class ChatsModel extends ViewModel with SnackbarMixin {
  final ChatService _chatService = locator<ChatService>();

  // Data

  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  late String _receiverName;
  String get receiverName => _receiverName;
  late ChatContactData _contact;
  ChatContactData get contact => _contact;

  List<ChatMessageData> _messages = [];
  List<ChatMessageData> get messages => _messages;

  bool _enableSendButton = false;
  bool get enableSendButton => _enableSendButton;

  int? _showDateTimeFor;
  bool showDateTime(int id) {
    return _showDateTimeFor != null && _showDateTimeFor == id;
  }

  set showDateTimeFor(int id) {
    if (_showDateTimeFor != id) {
      _showDateTimeFor = id;
    } else {
      _showDateTimeFor = null;
    }
    setIdle();
  }

  // Action
  Future<void> init(ChatsArgument argument) async {
    _contact = argument.contact;
    _receiverName =
        argument.contact.firstName + ' ' + argument.contact.lastName;
    setIdle();

    try {
      setLoading();

      _messages = await _chatService.messages(
          int.parse(_contact.to), int.parse(_contact.from));

      setIdle();

      _chatService.messagesStreamController.stream.listen(
        (messages) {
          _messages = messages;
          setIdle();
        },
      );

      if (!_messageController.hasListeners) {
        _messageController.addListener(() {
          _enableSendButton = _messageController.text.trim().isNotEmpty;
          setIdle();
        });
      }
    } catch (e) {
      setIdle();

      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: e.toString(),
        ),
      );
      goBack();
    }
  }

  @override
  void dispose() {
    _chatService.stopMessageStream();
    super.dispose();
  }

  Future<void> sendMessage() async {
    if (_messageController.text.trim().isEmpty) {
      return;
    }

    try {
      setWidgetBusy('send-btn');
      final message = await _chatService.sendMessage(
        receiverId: int.parse(_contact.from),
        senderId: int.parse(_contact.to),
        message: _messageController.text.trim(),
      );
      unsetWidgetBusy('send-btn');
      _messages.insert(0, message);
      _messageController.clear();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: e.toString(),
        ),
      );
      goBack();
    }
  }
}
