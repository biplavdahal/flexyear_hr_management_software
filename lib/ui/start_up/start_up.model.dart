import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/services/notification.service.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.view.dart';
import 'package:flex_year_tablet/ui/frontdesk/enter_pin/enter_pin.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.view.dart';
import 'package:flex_year_tablet/ui/personal/login/login.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartUpModel extends ViewModel with SnackbarMixin {
  // Services
  final AppAccessService _appAccessService = locator<AppAccessService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NotificationService _notificationService =
      locator<NotificationService>();

  Future<void> init() async {
    try {
      setLoading();
      await _appAccessService.init();

      if (_appAccessService.appAccess != null) {
        if (_appAccessService.appUsage == null) {
          gotoAndClear(AppAccessView.tag);
        } else {
          if (_appAccessService.appUsage == "PERSONAL") {
            final _isLoggedIn = await _authenticationService.isLoggedIn();
            if (_isLoggedIn) {
              debugPrint(_authenticationService.user?.accessToken);

              final notificationPermission =
                  await _notificationService.getPermission();
              if (!notificationPermission) {
                snackbar.displaySnackbar(
                  SnackbarRequest.of(
                    message: "You won't receive any notifications.",
                    action: SnackbarAction(
                      label: "Grant Permission",
                      onPressed: _notificationService.getPermission,
                    ),
                  ),
                );
              }

              _notificationService.initializeLocalNotification();

              final initialMessage =
                  await _notificationService.getInitialMessage();

              _notificationService
                  .onNotificationArrive()
                  .listen((message) async {
                debugPrint(message.notification?.body);
                debugPrint(message.notification?.title);

                _notificationService.showNotification(
                  title: message.notification?.title,
                  body: message.notification?.body,
                );
              });

              _notificationService.onMessageOpenedApp().listen((message) {
                debugPrint(message.data.toString());
              });

              if (initialMessage != null) {
                debugPrint(initialMessage.data.toString());
              }

              await locator<CompanyService>().init();
              gotoAndClear(DashboardView.tag);
            } else {
              gotoAndClear(LoginView.tag);
            }
          } else {
            if (_appAccessService.client == null) {
              gotoAndClear(AppAccessView.tag);
            } else {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
              gotoAndClear(EnterPinView.tag);
            }
          }
        }
      } else {
        gotoAndClear(AppAccessView.tag);
      }

      setSuccess();
    } catch (e) {
      setAlert(viewState: EState.error, message: e.toString());
      _authenticationService.logout();
      gotoAndClear(LoginView.tag);
    }
  }
}
