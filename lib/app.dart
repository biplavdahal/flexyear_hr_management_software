import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.manager.dart';
import 'package:flex_year_tablet/routes.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/start_up/start_up.view.dart';
import 'package:flutter/material.dart';

class FlexYearApp extends StatelessWidget {
  const FlexYearApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
<<<<<<< HEAD
      builder: (Widget, C) => MaterialApp(
=======
      builder: (Widget, c) => MaterialApp(
        supportedLocales: const [
          Locale('en', ''), //English
          Locale('ne', ''), //Nepali
        ],
>>>>>>> 1203f515737f04ac66069c1d1579959e5aa43f01
        debugShowCheckedModeBanner: false,
        theme: getThemeDataTheme(context),
        onGenerateRoute: (settings) =>
            locator<NavigationService>().generateRoute(
          settings,
          routesAndViews(settings),   
        ),
        builder: (context, child) {
          return Navigator(
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(
                      child: SnackbarManager(
                        behavior: SnackBarBehavior.floating,
                        elevation: 0,
                        infoColor: AppColor.primary,
                        errorColor: Colors.red,
                        successColor: Colors.green,
                        warningColor: AppColor.accent,
                        body: child!,
                      ),
                    )),
          );
        },
        navigatorKey: locator<NavigationService>().navigationKey,
        home: const StartUpView(),
      ),
      )
    );
  }
}
