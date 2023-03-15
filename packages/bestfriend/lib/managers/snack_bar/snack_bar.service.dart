import 'package:bestfriend/bestfriend.dart';

abstract class SnackbarService {
  void registerSnackbarListener(
    Function(SnackbarRequest request) showSnackbarListener,
  );

  Future<SnackbarResponse> displaySnackbar(SnackbarRequest request);
}
