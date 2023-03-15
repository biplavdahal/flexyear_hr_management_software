import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class FYSection extends StatelessWidget {
  final Widget? child;
  final String? title;
  final bool infoBox;

  const FYSection({Key? key, this.title, this.child, this.infoBox = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: infoBox ? const EdgeInsets.all(16) : EdgeInsets.zero,
      decoration: infoBox
          ? BoxDecoration(
              color: Colors.yellow.withOpacity(0.16),
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          if (title != null)
            Text(
              title!,
              style: TextStyle(
                color: infoBox ? Colors.deepOrange : AppColor.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          const SizedBox(height: 10),
          if (child != null) child!,
        ],
      ),
    );
  }
}
