import 'dart:async';

import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.service.dart';

class DialogServiceImplementation implements DialogService {
  late Function(DialogRequest request) _showDialogListener;
  late Function _hideDialogListener;
  late Completer<DialogResponse?>? _dialogCompleter;

  @override
  void hideDialog([DialogResponse? response, bool callHideListener = true]) {
    if (_dialogCompleter != null) {
      _dialogCompleter!.complete(response);
    }
    if (callHideListener) _hideDialogListener();
    _dialogCompleter = null;
  }

  @override
  void registerDialogListener(
      Function(DialogRequest request) showDialogListener,
      Function hideDialogListener) {
    _showDialogListener = showDialogListener;
    _hideDialogListener = hideDialogListener;
  }

  @override
  Future<DialogResponse?> showDialog(DialogRequest request) {
    _dialogCompleter = Completer();
    _showDialogListener(request);
    return _dialogCompleter!.future;
  }
}
