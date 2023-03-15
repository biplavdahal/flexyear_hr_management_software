import 'package:bestfriend/bestfriend.dart';
import 'package:example/constants/routes_name.dart';
import 'package:example/views/home/home.view.dart';
import 'package:example/views/second/second.view.dart';
import 'package:flutter/material.dart';

Map<String, Widget> routesAndViews(RouteSettings settings) => {
      homeViewRoute: const HomeView(),
      secondViewRoute: SecondView(settings.arguments as Arguments),
    };
