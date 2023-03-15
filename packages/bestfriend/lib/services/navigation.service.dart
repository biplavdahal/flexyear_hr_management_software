import 'package:bestfriend/bestfriend.dart';
import 'package:flutter/material.dart';

abstract class NavigationService {
  /// Returns [true] if we can navigate back to previous screen.
  bool get canGoBack;

  /// Navigation key for the app.
  GlobalKey<NavigatorState> get navigationKey;

  /// This method will pop the view i.e. remove the current view from
  /// stack and show the underneath view.
  void pop({dynamic result});

  /// This method will navigate to new route.
  Future<dynamic> navigateTo(String routeName, {dynamic arguments});

  /// This method will navigate to a new route while remove the current
  /// route from the route stack.
  Future<dynamic> navigateToAndPop(String routeName, {dynamic arguments});

  /// This method will navigate to a new route and clear every other router
  /// before it.
  Future<dynamic> navigateToAndClearStack(String routeName,
      {dynamic arguments});

  /// This method will generate routes.
  Route<dynamic> generateRoute<T extends View>(
      RouteSettings settings, Map<String, Widget> views);
}
