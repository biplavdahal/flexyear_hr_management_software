import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class FYDateField extends StatelessWidget {
  final DateTime? value;
  final String? title;
  final ValueSetter<DateTime?>? onChanged;

  final DateTime? firstDate;

  final DateTime? lastDate;
  final Icon? icon;

  const FYDateField({
    Key? key,
    this.value,
    this.icon,
    this.title,
    this.onChanged,
    this.firstDate,
    this.lastDate,
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
        GestureDetector(
          onTap: () {
            _showDatePicker(context);
          },
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    value != null
                        ? formattedDate(value.toString())
                        : "Select date...",
                    style: value == null
                        ? const TextStyle(
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final _pickedDate = await showDatePicker(
      context: context,
      helpText: title,
      initialDate: value ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ??
          DateTime.now().add(
            const Duration(days: 365),
          ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.primary,
            ),
            dialogBackgroundColor: AppColor.scaffold,
          ),
          child: child!,
        );
      },
    );

    if (_pickedDate != null) {
      onChanged?.call(_pickedDate);
    }
  }
}

class FYTimeField extends StatelessWidget {
  final TimeOfDay? value;
  final String? title;
  final ValueSetter<TimeOfDay?>? onChanged;

  const FYTimeField({
    Key? key,
    this.value,
    this.title,
    this.onChanged,
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
        GestureDetector(
          onTap: () {
            _showTimePicker(context);
          },
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                value != null
                    ? "${value!.hour}:${value!.minute}"
                    : 'Select time',
                style: value == null
                    ? const TextStyle(
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final _pickedTime = await showTimePicker(
      context: context,
      initialTime: value ?? TimeOfDay.now(),
      helpText: title,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (_pickedTime != null) {
      onChanged?.call(_pickedTime);
    }
  }
}
