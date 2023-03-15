import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/helper/fy_validator.helper.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../../../widgets/fy_checkbox.widget.dart';
import '../../../widgets/fy_nepali_date_time_field.widget.dart';

class AttendanceReportFilterView extends StatelessWidget {
  static String tag = 'attendance-report-filter-view';

  final Arguments? arguments;

  const AttendanceReportFilterView(
    this.arguments, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AttendanceReportFilterModel>(
      onModelReady: (model) =>
          model.init(arguments as AttendanceReportFilterArguments),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.filterType == AttendanceReportFilterType.daily ||
                      model.filterType ==
                          AttendanceReportFilterType.oneDayReport
                  ? 'One Day Report'
                  : model.filterType == AttendanceReportFilterType.weekly
                      ? 'Weekly Report'
                      : 'Monthly Report',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (model.clients != null && model.clients!.isNotEmpty)
                      FYDropdown<ClientData>(
                        items: model.clients!,
                        labels: model.clientsLabel!,
                        value: model.selectedClientLabel!,
                        title: 'Select client',
                        onChanged: (value) =>
                            model.selectedClientLabel = value!,
                      ),
                    const SizedBox(height: 16),
                    if (locator<AuthenticationService>()
                            .user!
                            .role
                            ?.toLowerCase() ==
                        "manager")
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 8,
                          children: [
                            for (int i = 0;
                                i < model.selectedStaffs.length;
                                i++)
                              Chip(
                                label: Text(
                                    model.selectedStaffs.toList()[i].fullName),
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
                    if (locator<AuthenticationService>().user!.role ==
                        "Manager")
                      const SizedBox(height: 16),
                    FYDropdown<String>(
                      items: model.attendanceTypes,
                      labels: model.attendanceTypes,
                      value: model.selectedAttendanceType,
                      title: 'Attendance Type',
                      onChanged: (value) =>
                          model.selectedAttendanceType = value!,
                    ),
                    const SizedBox(height: 16),
                    if (model.filterType == AttendanceReportFilterType.daily ||
                        model.filterType ==
                            AttendanceReportFilterType.oneDayReport)
                      _buildFieldForDailyReportFilter(model),
                    if (model.filterType == AttendanceReportFilterType.weekly)
                      _buildFieldForWeeklyReportFilter(model),
                    if (model.filterType == AttendanceReportFilterType.monthly)
                      if (model.isNepaliDate == false)
                        _buildFieldForMonthlyReportFilter(model),
                    if (model.isNepaliDate == true)
                      _buildFieldForMonthlyNepaliReportFilter(model),
                    const SizedBox(
                      height: 10,
                    ),
                    if (model.filterType == AttendanceReportFilterType.monthly)
                      if (model.isNepaliDate == false)
                        _buildFieldForDateMonthlyReportFilter(model),
                    if (model.isNepaliDate == true)
                      _buildFieldForNepaliWeekelyReportFilter(model),
                    const SizedBox(height: 16),
                    FYPrimaryButton(
                      label: "View Report",
                      onPressed: model.onViewReportPressed,
                    ),
                    if (locator<AuthenticationService>()
                            .user!
                            .role
                            ?.toLowerCase() !=
                        "staff")
                      const SizedBox(height: 16),
                    if (locator<AuthenticationService>()
                            .user!
                            .role
                            ?.toLowerCase() !=
                        "staff")
                      const Text(
                        "Note: Not selecting any staff will, by default, show your own report.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldForDailyReportFilter(AttendanceReportFilterModel model) {
    return FYDateField(
      title: "Attendance Date",
      onChanged: (value) => model.attendanceDate = value!,
      value: model.attendanceDate,
      firstDate: DateTime.now().subtract(
        const Duration(days: 365 * 7),
      ),
      lastDate: DateTime.now(),
    );
  }

  Widget _buildFieldForWeeklyReportFilter(AttendanceReportFilterModel model) {
    return Row(
      children: [
        Expanded(
          child: FYDateField(
            title: "Week From",
            onChanged: (value) => model.weekFrom = value!,
            value: model.weekFrom,
            firstDate: DateTime.now().subtract(
              const Duration(days: 365 * 7),
            ),
            lastDate: DateTime.now(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FYDateField(
            title: "Week To",
            value: model.weekTo,
          ),
        ),
      ],
    );
  }

  Widget _buildFieldForMonthlyReportFilter(AttendanceReportFilterModel model) {
    return Row(
      children: [
        Expanded(
            child: FYDropdown<String>(
          items: model.months,
          labels: model.months,
          value: model.selectedMonth,
          title: 'Month',
          onChanged: (value) => model.selectedMonth = value!,
        )),
        Expanded(
          child: FYCheckbox(
              value: model.isNepaliDate,
              onChanged: (value) => model.isNepaliDate = value!,
              label: "नेपाली"),
        ),
      ],
    );
  }

  Widget _buildFieldForMonthlyNepaliReportFilter(
      AttendanceReportFilterModel model) {
    return Row(
      children: [
        Expanded(
            child: FYDropdown<String>(
          items: model.nepaliMonths,
          labels: model.nepaliMonths,
          value: model.selectedNepaliMonth,
          title: "महिना",
          onChanged: (value) => model.selectedNepaliMonth = value!,
        )),
        Expanded(
            child: FYCheckbox(
                value: model.isNepaliDate,
                onChanged: (value) => model.isNepaliDate = value!,
                label: "नेपाली"))
      ],
    );
  }

  Widget _buildFieldForDateMonthlyReportFilter(
      AttendanceReportFilterModel model) {
    return Row(
      children: [
        Form(
          key: model.formKey,
          child: Expanded(
            child: FYDateField(
              title: "Date From",
              onChanged: (value) => model.dateFrom = value!,
              value: model.dateFrom,
              firstDate: DateTime.now().subtract(
                const Duration(days: 365 * 7),
              ),
              lastDate: DateTime.now(),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Form(
          child: Expanded(
              child: FYDateField(
            title: "Date To",
            onChanged: (value) => model.dateTo = value!,
            value: model.dateTo,
            firstDate: DateTime.now().subtract(
              const Duration(days: 365 * 7),
            ),
            lastDate: DateTime.now(),
          )),
        )
      ],
    );
  }

  Widget _buildFieldForNepaliWeekelyReportFilter(
      AttendanceReportFilterModel model) {
    return Row(
      children: [
        Expanded(
          child: FYNepaliDateField(
            title: "मिति देखि :",
            onNepaliChanged: (value) => model.nepaliDateFrom = value!,
            nepaliValue: model.nepaliDateFrom,
            nepaliFirstDate: NepaliDateTime.now().subtract(
              const Duration(days: 365 * 7),
            ),
            nepaliLastDate: NepaliDateTime.now(),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: FYNepaliDateField(
            title: "मिति सम्म :",
            nepaliValue: model.nepaliDateTo,
          ),
        )
      ],
    );
  }
}
