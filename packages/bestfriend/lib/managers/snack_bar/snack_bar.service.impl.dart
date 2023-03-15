import 'dart:async';

import 'package:bestfriend/bestfriend.dart';

class SnackbarServiceImplementation implements SnackbarService {
  late Function(SnackbarRequest request) _showSnackbarListener;
  late Completer<SnackbarResponse>? _snackbarCompleter;

  @override
  void registerSnackbarListener(
      Function(SnackbarRequest request) showSnackbarListener) {
    _showSnackbarListener = showSnackbarListener;
  }

  @override
  Future<SnackbarResponse> displaySnackbar(SnackbarRequest request) {
    _snackbarCompleter = Completer();
    _showSnackbarListener(request);
    return _snackbarCompleter!.future;
  }
}
