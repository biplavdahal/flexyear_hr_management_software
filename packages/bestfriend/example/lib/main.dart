import 'package:bestfriend/bestfriend.dart';
import 'package:example/routes.dart';
import 'package:example/setup_locator.dart';
import 'package:example/views/home/home.view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: (settings) => locator<NavigationService>().generateRoute(
        settings,
        routesAndViews(settings),
      ),
      builder: (context, child) {
        return Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => SnackbarManager(
              infoColor: Colors.black,
              behavior: SnackBarBehavior.floating,
              body: child!,
            ),
          ),
        );
      },
      home: const HomeView(),
    );
  }
}
