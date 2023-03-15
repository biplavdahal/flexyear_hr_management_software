import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/ui/frontdesk/enter_pin/enter_pin.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppAccessClientCodeModel extends ViewModel with SnackbarMixin {
  // Services
  final AppAccessService _appAccessService = locator<AppAccessService>();

  // UI Controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _codeController = TextEditingController();
  TextEditingController get codeController => _codeController;

  // Action
  Future<void> onSubmit() async {
    try {
      if (_formKey.currentState!.validate()) {
        setLoading();

        await _appAccessService.getClientAccess(codeController.text);

        setIdle();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
        gotoAndClear(EnterPinView.tag);
      }
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
