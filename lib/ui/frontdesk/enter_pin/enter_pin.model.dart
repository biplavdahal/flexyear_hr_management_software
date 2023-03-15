import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:bestfriend/bestfriend.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flex_year_tablet/constants/prefs.constants.dart';
import 'package:flex_year_tablet/data_models/app_access.data.dart';
import 'package:flex_year_tablet/data_models/pin.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/tablet.service.dart';
import 'package:flex_year_tablet/ui/frontdesk/attendance/attendance.view.dart';
import 'package:flutter/material.dart';

class EnterPinModel extends ViewModel with DialogMixin, SnackbarMixin {
  // Service
  final AppAccessService _accessService = locator<AppAccessService>();
  final TabletService _tabletService = locator<TabletService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  // UI Controllers
  final TextEditingController _pinController = TextEditingController();
  TextEditingController get pinController => _pinController;

  // Data
  AppAccessData get appAccessData => _accessService.appAccess!;

  List<List<String>> get inputs => [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "<"]
      ];

  String _currentDateTime = DateTime.now().toString();
  String get currentDateTime => _currentDateTime;

  String? _lastSyncedDate;
  String? get lastSyncedDate => _lastSyncedDate;

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  List<PinData> _pins = [];

  // Action
  Future<void> init() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDateTime = DateTime.now().toString();
      setIdle();
    });

    await Future.delayed(const Duration(milliseconds: 500));

    dialog.showDialog(
      DialogRequest(type: DialogType.progress, title: 'Retriving pins'),
    );

    final _connectivityResult = await Connectivity().checkConnectivity();

    if (_connectivityResult != ConnectivityResult.none) {
      _isOnline = true;
      try {
        await _tabletService.loadPins();
        _pins = _tabletService.pins;

        await _sharedPreferenceService.set<String>(pfPins, jsonEncode(_pins));
        await _sharedPreferenceService.set<String>(
            pfLastPinSynced, DateTime.now().toString());
      } catch (e) {
        snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
      }
    } else {
      final _savedPins = await _sharedPreferenceService.get<String?>(pfPins);

      if (_savedPins.value != null) {
        _pins = (jsonDecode(_savedPins.value!) as List<dynamic>)
            .map((pin) => PinData.fromJson(pin))
            .toList();
      }
    }

    _lastSyncedDate =
        (await _sharedPreferenceService.get<String?>(pfLastPinSynced)).value;

    dialog.hideDialog();
    setIdle();

    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _isOnline = true;
      } else {
        _isOnline = false;
      }
      setIdle();
    });
  }

  void onInputCellPressed(String pin) {
    if (pin != "<") {
      if (_pinController.text.length < 6) {
        _pinController.text += pin;
      }
    } else {
      _pinController.text =
          _pinController.text.substring(0, _pinController.text.length - 1);
    }
    setIdle();
  }

  Future<void> onPinEnterCompleted(String plainPin) async {
    final userPin = md5.convert(utf8.encode(plainPin)).toString();

    dialog.showDialog(
      DialogRequest(type: DialogType.progress, title: 'Checking pin'),
    );

    final _savedPins = await _sharedPreferenceService.get<String?>(pfPins);

    if (_savedPins.value != null) {
      _pins = (jsonDecode(_savedPins.value!) as List<dynamic>)
          .map((pin) => PinData.fromJson(pin))
          .toList();

      final exist = _pins.any((pin) => pin.pin == userPin);

      if (exist) {
        _tabletService.loggedInAs =
            _pins.firstWhere((pin) => pin.pin == userPin);
        goto(AttendanceView.tag);
      } else {
        snackbar.displaySnackbar(
          SnackbarRequest.of(
            message: 'Pin not found.',
            type: ESnackbarType.error,
          ),
        );
      }
    }

    dialog.hideDialog();
    _pinController.clear();
  }
}
