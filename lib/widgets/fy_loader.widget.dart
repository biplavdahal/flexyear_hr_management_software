import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class FYLinearLoader extends StatelessWidget {
  final double? width;

  const FYLinearLoader({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      clipBehavior: Clip.hardEdge,
      child: LinearProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: const AlwaysStoppedAnimation<Color>(AppColor.accent),
      ),
    );
  }
}
