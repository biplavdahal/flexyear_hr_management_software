import 'dart:async';

import 'package:bestfriend/bestfriend.dart';
import 'package:dio/dio.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/chat_contact.data.dart';
import 'package:flex_year_tablet/data_models/chat_message.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/chat.service.dart';
import 'package:flutter/material.dart';

class ChatServiceImpl implements ChatService {
  final ApiService _apiService = locator<ApiService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();

  // Data
  late StreamController<List<ChatMessageData>> _chatStreamController;
  late Timer? _timer;

  @override
  StreamController<List<ChatMessageData>> get messagesStreamController =>
      _chatStreamController;

  @override
  Future<List<ChatContactData>> getContacts() async {
    try {
      final _response = await _apiService.get(auGetContactLists, params: {
        'access_token': _authenticationService.user!.accessToken,
        'id': _authenticationService.user!.id,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        debugPrint(data.toString());
        throw data["response"];
      }

      return data['data']
          .map<ChatContactData>((json) => ChatContactData.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw apiError(e);
    }
  }

  Future<List<ChatMessageData>> _fetchMessages(
      int receiverId, int senderId) async {
    try {
      debugPrint({
        'access_token': _authenticationService.user!.accessToken,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'company_id': _appAccessService.appAccess!.company.companyId,
      }.toString());

      final response = await _apiService.get(auGetMessages, params: {
        'access_token': _authenticationService.user!.accessToken,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(response.data);

      if (data!["status"] == "failure") {
        throw data['response'];
      }

      List<ChatMessageData> _messages = [];

      final threadsJson = data["data"] as List;

      for (final threadJson in threadsJson) {
        _messages.add(ChatMessageData.fromJson(threadJson));
      }

      if (!_chatStreamController.isClosed) {
        _chatStreamController.add(_messages.reversed.toList());
      }

      return _messages.reversed.toList();
    } on DioError catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<List<ChatMessageData>> messages(int receiverId, int senderId) async {
    try {
      _chatStreamController =
          StreamController<List<ChatMessageData>>.broadcast();
      final data = await _fetchMessages(receiverId, senderId);

      Stopwatch watch = Stopwatch();
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        if (!watch.isRunning) {
          watch.start();
          await _fetchMessages(receiverId, senderId);
          watch.stop();
        }
      });

      return data;
    } on DioError catch (e) {
      throw apiError(e);
    }
  }

  @override
  void stopMessageStream() {
    if (_timer != null) {
      _timer?.cancel();
    }
    _chatStreamController.close();
  }

  @override
  Future<ChatMessageData> sendMessage({
    required int receiverId,
    required int senderId,
    required String message,
  }) async {
    try {
      debugPrint({
        'access_token': _authenticationService.user!.accessToken,
        'receiver_id': receiverId,
        'sender_id': senderId,
        'message': message,
      }.toString());
      final response = await _apiService.post(
        auSendTextMessage,
        {
          'access_token': _authenticationService.user!.accessToken,
          'receiver_id': receiverId,
          'sender_id': senderId,
          'message': message,
        },
        asFormData: true,
      );

      final data = constructResponse(response.data);

      if (data!["status"] == "failure") {
        throw data['response'];
      }

      return ChatMessageData.fromJson({
        ...data['data'],
        'sender_id': int.parse(data['data']['sender_id']),
      });
    } on DioError catch (e) {
      throw apiError(e);
    }
  }
}
