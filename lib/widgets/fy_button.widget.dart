import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class FYPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const FYPrimaryButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor ?? AppColor.primary,
        side: BorderSide(
          color: backgroundColor ?? AppColor.primary,
          width: 2,
        ),
      ),
    );
  }
}

class FYSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const FYSecondaryButton({Key? key, required this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
