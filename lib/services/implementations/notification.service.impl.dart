import 'dart:io';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bestfriend/di.dart';
import 'package:bestfriend/services/api.service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/notice.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/dio_helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/notification.service.dart';

import '../authentication.service.dart';

class NotificationServiceImplementation implements NotificationService {
  // External depedencies
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final ApiService _apiService = locator<ApiService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();
  @override
  Future<bool> getPermission() async {
    if (Platform.isIOS) {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      return (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional);
    }

    bool localNotificationAllowed =
        await AwesomeNotifications().isNotificationAllowed();

    if (!localNotificationAllowed) {
      localNotificationAllowed =
          await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    return localNotificationAllowed;
  }

  @override
  Future<RemoteMessage?> getInitialMessage() {
    return _firebaseMessaging.getInitialMessage();
  }

  @override
  void initializeLocalNotification() async {
    AwesomeNotifications().initialize(
      'resource://drawable/ic_notification_logo', // icon for your app notification
      [
        NotificationChannel(
          channelKey: 'channel1',
          channelName: 'FlexYear',
          channelDescription:
              "This channel contains all of the foreground notifications.",
          playSound: true,
          enableLights: true,
          enableVibration: true,
        ),
      ],
    );
  }

  @override
  Stream<RemoteMessage> onMessageOpenedApp() {
    return FirebaseMessaging.onMessageOpenedApp;
  }

  @override
  Stream<RemoteMessage> onNotificationArrive() {
    return FirebaseMessaging.onMessage;
  }

  @override
  Future<void> showNotification(
      {String? title, String? body, String? payload}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'channel1',
        title: title,
        body: body,
      ),
    );
  }

  @override
  Future<void> cancelNotification([String? key]) async {
    await AwesomeNotifications().cancelAll();
  }

  bool _hasMore = true;
  @override
  bool get hasMore => _hasMore;

  final List<NoticeData> _notices = [];
  @override
  List<NoticeData> get notices => _notices;

  final int maxLimit = 4;
  int _currentPage = 0;

  @override
  Future<void> fetchNotices() async {
    if (_hasMore) {
      try {
        _currentPage++;

        final response = await _apiService.get(auStaffDashboard, params: {
          'access_token': _authenticationService.user!.accessToken,
          'company_id': _appAccessService.appAccess!.company.companyId
        });
        final data = constructResponse(response.data);

        if (data!["status"] == "failure") {
          throw apiError(e);
        }
        final noticesJson = data["data"] as List;

        for (final noticeJson in noticesJson) {
          _notices.add(NoticeData.fromJson(noticeJson));
        }
        _hasMore = maxLimit * _currentPage < data["count"];
      } on DioError catch (e) {
        throw dioError(e);
      }
    }
  }
}
