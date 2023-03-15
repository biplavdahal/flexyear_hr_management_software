import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../theme.dart';

class FYNepaliDateField extends StatelessWidget {
  final NepaliDateTime? nepaliValue;
  final String? title;
  final ValueSetter<NepaliDateTime?>? onNepaliChanged;
  final NepaliDateTime? nepaliFirstDate;
  final NepaliDateTime? nepaliLastDate;
  final Icon? icon;

  const FYNepaliDateField(
      {Key? key,
      this.nepaliValue,
      this.title,
      this.onNepaliChanged,
      this.nepaliFirstDate,
      this.nepaliLastDate,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        if (title != null)
          const SizedBox(
            height: 8,
          ),
        GestureDetector(
          onTap: () {
            _showNepaliDatePicker(context);
          },
          child: InputDecorator(
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
            )),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                      nepaliValue != null
                          ? formattedDate(nepaliValue.toString())
                          : "Select date...",
                      style: nepaliValue == null
                          ? const TextStyle(color: Colors.grey)
                          : null),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _showNepaliDatePicker(BuildContext context) async {
    final _pickedNepaiDate = await showMaterialDatePicker(
        context: context,
        // locale: const Locale('ne'),
        initialDate: nepaliValue ?? NepaliDateTime.now(),
        firstDate: nepaliFirstDate ?? NepaliDateTime.now(),
        lastDate: nepaliLastDate ??
            NepaliDateTime.now().add(
              const Duration(),
            ),
        builder: (context, child) {
          return Theme(
              data: ThemeData.dark().copyWith(
                  colorScheme:
                      const ColorScheme.light(primary: AppColor.primary),
                  dialogBackgroundColor: AppColor.scaffold),
              child: child!);
        });
    if (_pickedNepaiDate != null) {
      onNepaliChanged?.call(_pickedNepaiDate);
    }
  }
}
