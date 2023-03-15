import 'package:bestfriend/bestfriend.dart';
import 'package:flutter/cupertino.dart';

class ViewModel extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();

  // [States and State manager start]
  final Map<String, bool> _busyWidgetsMap = {};

  EState _state = EState.idle;
  EState get state => _state;
   void setState(EState viewState) {
    _state = viewState;
    notifyListeners();
  }

  late String _errorMessage = "";
  String get errorMessage => _errorMessage;

  late String _warningMessage = "";
  String get warningMessage => _warningMessage;

  void setAlert({
    required EState viewState,
    required String message,
  }) {
    if (viewState == EState.error) {
      _errorMessage = message;
    } else if (viewState == EState.warning) {
      _warningMessage = message;
    }

    setState(viewState);
  }

   void setLoading() {
    setState(EState.loading);
  }

  void setSuccess() {
    setState(EState.success);
  }

  void setIdle() {
    setState(EState.idle);
  }

  // Use [setWidgetBusy(), unsetWidgetBusy()] if you want to only show progress indicator to
  // certain widget.
  void setWidgetBusy(String key) {
    if (_busyWidgetsMap.containsKey(key)) {
      _busyWidgetsMap.update(key, (_) => true);
    } else {
      _busyWidgetsMap.putIfAbsent(key, () => true);
    }
    notifyListeners();
  }

  void unsetWidgetBusy(String key) {
    if (_busyWidgetsMap.containsKey(key)) {
      _busyWidgetsMap.update(key, (_) => false);
    } else {
      _busyWidgetsMap.putIfAbsent(key, () => false);
    }
    notifyListeners();
  }

  /// This getter function will return a boolean value which will
  /// indicate if the model state is loading or not.
  bool get isLoading => _state == EState.loading;

  bool isBusyWidget(String key) => _busyWidgetsMap[key] ?? false;

  // [States and State manager end]

  // [Model disposal/reuse logic start]
  bool _onModelReadyCalled = false;
  bool get onModelReadyCalled => _onModelReadyCalled;
  void setOnModelReadyCalled({required bool status}) {
    _onModelReadyCalled = status;
  }
  // [Model disposal/reuse logic end]

  // [Global methods start]
  Future goto(String routeName, {Arguments? arguments}) async {
    return await _navigationService.navigateTo(routeName, arguments: arguments);
  }

  Future gotoAndPop(String routeName, {Arguments? arguments}) async {
    return await _navigationService.navigateToAndPop(routeName,
        arguments: arguments);
  }

  Future gotoAndClear(String routeName, {Arguments? arguments}) async {
    return await _navigationService.navigateToAndClearStack(routeName,
        arguments: arguments);
  }

  void goBack({dynamic result}) {
    _navigationService.pop(result: result);
  }

  bool get canGoBack => _navigationService.canGoBack;
  // [Global methods end]

}
