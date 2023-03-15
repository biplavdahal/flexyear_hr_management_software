import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  static String tag = 'test-view';

  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('COOOOOOÔL'),
      ),
    );
  }
}
