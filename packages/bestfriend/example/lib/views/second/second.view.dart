import 'package:bestfriend/bestfriend.dart';
import 'package:example/views/second/second.model.dart';
import 'package:flutter/material.dart';

class SecondView extends StatelessWidget {
  final Arguments arguments;

  const SecondView(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<SecondModel>(
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Second View"),
          ),
          body: Center(
            child: Text((arguments as SecondViewArguments).message),
          ),
        );
      },
    );
  }
}

class SecondViewArguments extends Arguments {
  final String message;

  SecondViewArguments(this.message);
}
