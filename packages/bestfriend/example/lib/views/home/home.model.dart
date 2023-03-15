import 'package:bestfriend/bestfriend.dart';

class HomeModel extends ViewModel with SnackbarMixin {
  void showSnackbar() {
    snackbar.displaySnackbar(
      SnackbarRequest.of(
        type: ESnackbarType.success,
        message: "Hello world",
        duration: ESnackbarDuration.long,
      ),
    );
  }
}
