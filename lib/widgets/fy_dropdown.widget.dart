import 'package:flutter/material.dart';

class FYDropdown<T> extends StatelessWidget {
  final String? title;
  final ValueSetter<String?> onChanged;
  final List<T> items;
  final List<String> labels;
  final String value;

  const FYDropdown({
    Key? key,
    required this.onChanged,
    required this.items,
    required this.labels,
    required this.value,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (title != null) const SizedBox(height: 8),
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  errorStyle:
                      const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isDense: true,
                  onChanged: onChanged,
                  items: labels.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
