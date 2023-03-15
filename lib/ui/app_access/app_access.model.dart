import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/app_access.data.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/ui/app_access_client_code/app_access_client_code.view.dart';
import 'package:flex_year_tablet/ui/personal/login/login.view.dart';
import 'package:flutter/material.dart';

class AppAccessModel extends ViewModel with SnackbarMixin {
  // Services
  final AppAccessService _appAccessService = locator<AppAccessService>();

  // UI Controllers
  final GlobalKey<FormState> _appAccessFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get appAccessFormKey => _appAccessFormKey;

  final TextEditingController _appAccessController = TextEditingController();
  TextEditingController get appAccessController => _appAccessController;

  // Data
  AppAccessData? _appAccess;
  AppAccessData? get appAccess => _appAccess;

  // Action
  Future<void> init() async {
    _appAccess = _appAccessService.appAccess;
    setIdle();
  }

  Future<void> onVerifyKeyPressed() async {
    if (_appAccessFormKey.currentState!.validate()) {
      try {
        setLoading();
        await _appAccessService.getAppAccess(appAccessController.text);

        _appAccess = _appAccessService.appAccess;

        setSuccess();
      } catch (e) {
        setIdle();
        snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
      }
    }
  }

  void onUsagesPressed(String usage) {
    _appAccessService.appUsage = usage;
    if (usage == "PERSONAL") {
      goto(LoginView.tag);
    } else {
      goto(AppAccessClientCodeView.tag);
    }
  }

  void onResetPressed() async {
    await _appAccessService.clearData();
    _appAccess = null;
    setIdle();
  }
}
