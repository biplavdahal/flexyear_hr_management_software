import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/ui/personal/add_attendance/add_attendance.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_checkbox.widget.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_dropdown.widget.dart';
import 'package:flutter/material.dart';

class AddAttendanceView extends StatelessWidget {
  static String tag = 'add-attendance-view';

  const AddAttendanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AddAttendanceModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Attendance'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (model.clients != null && model.clients!.isNotEmpty)
                    FYDropdown<ClientData>(
                      items: model.clients!,
                      labels: model.clientsLabel!,
                      value: model.selectedClientLabel!,
                      title: 'Select client',
                      onChanged: (value) => model.selectedClientLabel = value!,
                    ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      children: [
                        for (int i = 0; i < model.selectedStaffs.length; i++)
                          Chip(
                            label:
                                Text(model.selectedStaffs.toList()[i].fullName),
                            onDeleted: () {
                              model.selectedStaffs.remove(
                                model.selectedStaffs.toList()[i],
                              );
                              model.setIdle();
                            },
                          ),
                        ActionChip(
                          label: const Text("Select Staffs"),
                          onPressed: model.onSelectStaffPressed,
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  FYDateField(
                    title: 'Attendance Date',
                    onChanged: (value) => model.attendanceDate = value,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365)),
                    value: model.attendanceDate,
                    lastDate: DateTime.now(),
                  ),
                  const SizedBox(height: 16),
                  FYCheckbox(
                    value: model.isCheckinCheckoutSelected,
                    onChanged: (value) =>
                        model.isCheckinCheckoutSelected = value!,
                    label: 'Add checkin/checkout time',
                  ),
                  const SizedBox(height: 16),
                  FYCheckbox(
                    value: model.isLunchInLunchOutSelected,
                    onChanged: (value) =>
                        model.isLunchInLunchOutSelected = value!,
                    label: 'Add lunch in/out time',
                  ),
                  if (model.isCheckinCheckoutSelected) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FYTimeField(
                            title: 'Check in Time',
                            onChanged: (value) => model.checkInTime = value,
                            value: model.checkInTime,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FYTimeField(
                            title: 'Check out Time',
                            onChanged: (value) => model.checkOutTime = value,
                            value: model.checkOutTime,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (model.isLunchInLunchOutSelected) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FYTimeField(
                            title: 'Lunch in Time',
                            onChanged: (value) => model.lunchInTime = value,
                            value: model.lunchInTime,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FYTimeField(
                            title: 'Lunch out Time',
                            onChanged: (value) => model.lunchOutTime = value,
                            value: model.lunchOutTime,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FYPrimaryButton(
                      label: 'Add Attendance',
                      onPressed: model.onAddAttendancePressed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
