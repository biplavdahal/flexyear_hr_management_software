import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class FYCheckbox extends StatelessWidget {
  final bool value;
  final ValueSetter<bool?>? onChanged;
  final String label;

  const FYCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Row(children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColor.primary,
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Text(label),
      ]),
    );
  }
}
