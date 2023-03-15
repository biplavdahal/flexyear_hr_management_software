import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../../../services/app_access.service.dart';

class LoginModel extends ViewModel with DialogMixin, SnackbarMixin {
  // Services
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final LocalAuthentication _auth = LocalAuthentication();
  final AppAccessService _appAccessService = locator<AppAccessService>();

  // UI components
  final GlobalKey<FormState> _loginWithPinFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get loginWithPinFormKey => _loginWithPinFormKey;
  final GlobalKey<FormState> _loginWithUsernamePasswordFormKey =
      GlobalKey<FormState>();
  GlobalKey<FormState> get loginWithUsernamePasswordFormKey =>
      _loginWithUsernamePasswordFormKey;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get pinController => _pinController;
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get forgotPasswordFormKey => _forgotPasswordFormKey;

  final TextEditingController _forgotPasswordEmailController =
      TextEditingController();
  TextEditingController get forgotPasswordEmailController =>
      _forgotPasswordEmailController;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  set rememberMe(bool value) {
    _rememberMe = value;
    setIdle();
  }

  bool _showLoginWithPin = false;
  bool get showLoginWithPin => _showLoginWithPin;
  set showLoginWithPin(bool value) {
    _showLoginWithPin = value;
    setIdle();
  }

  // Actions
  Future<void> init() async {
    _usernameController.text =
        await _authenticationService.getSavedUsername() ?? "";
    _passwordController.text =
        await _authenticationService.getSavedPassword() ?? "";

    setIdle();
  }

  Future<void> login() async {
    try {
      if (_showLoginWithPin && loginWithPinFormKey.currentState!.validate()) {
        dialog.showDialog(
          DialogRequest(
            type: DialogType.progress,
            title: "Checking login detail...",
          ),
        );

        await _loginWithPin();
      } else if (!_showLoginWithPin &&
          loginWithUsernamePasswordFormKey.currentState!.validate()) {
        dialog.showDialog(
          DialogRequest(
            type: DialogType.progress,
            title: "Checking login detail...",
          ),
        );
        await _loginWithUsernameAndPassword();
      }
      dialog.hideDialog();
    } catch (e) {
      dialog.hideDialog();
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> _loginWithUsernameAndPassword() async {
    try {
      await _authenticationService.authByUsername(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );

      if (_rememberMe) {
        await _authenticationService.saveUsername(_usernameController.text);
      }
      if (_rememberMe) {
        await _authenticationService.savePassword(_passwordController.text);
      }

      await locator<CompanyService>().init();
      debugPrint(_authenticationService.user.toString());
      setSuccess();
      gotoAndClear(DashboardView.tag);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loginWithPin() async {
    try {
      await _authenticationService.authByPin(
        pin: _pinController.text,
      );

      await locator<CompanyService>().init();

      setSuccess();
      gotoAndClear(DashboardView.tag);
    } catch (e) {
      rethrow;
    }
  }

     // FIXME: API ERROR
  Future<void> onForgotPasswordPressed() async {
    if (_forgotPasswordFormKey.currentState!.validate()) {
      dialog.showDialog(
        DialogRequest(
          type: DialogType.progress,
          title: "Please wait... Processing your request...",
          dismissable: true,
        ),
      );

      try {
        final response = await _authenticationService.requestResetPassword(
            email: _forgotPasswordEmailController.text.trim(),
            company_id: _appAccessService.appAccess!.company.companyId);
        snackbar.displaySnackbar(
          SnackbarRequest.of(
            message: response,   
            type: ESnackbarType.success,
            duration: ESnackbarDuration.long,
          ),
        );
      } catch (e) {
        rethrow;
      }

      dialog.hideDialog();
    }
  }

  Future<bool> _loginWithFingerprint() async {
    await getBiometrics();
    try {
      final isSupport = await _auth.isDeviceSupported();
      if (!isSupport) {
        return false;
      }
      return await _auth.authenticate(
        localizedReason: 'Scan FingerPrint to authenticate',
      );
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType>[];
    }
  }
}
