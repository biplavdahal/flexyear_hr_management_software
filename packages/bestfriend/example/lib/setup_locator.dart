import 'package:bestfriend/bestfriend.dart';
import 'package:example/views/home/home.model.dart';
import 'package:example/views/second/second.model.dart';

Future<void> setupLocator() async {
  locator.registerLazySingleton<SnackbarService>(
      () => SnackbarServiceImplementation());
  locator.registerLazySingleton<NavigationService>(
      () => NavigationServiceImplementation());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => SecondModel());
}
