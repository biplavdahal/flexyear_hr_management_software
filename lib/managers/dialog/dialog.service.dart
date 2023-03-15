import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';

abstract class DialogService {
  void registerDialogListener(
      Function(DialogRequest request) showDialogListener,
      Function hideDialogListener);

  Future<DialogResponse?> showDialog(DialogRequest dialogRequest);

  void hideDialog([DialogResponse response, bool callHideListener = true]);
}
