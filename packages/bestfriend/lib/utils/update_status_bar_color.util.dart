import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void updateStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color,
    statusBarIconBrightness: Brightness.light,
  ));
}
