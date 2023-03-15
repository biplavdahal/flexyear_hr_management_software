import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_checkbox.widget.dart';
import 'package:flex_year_tablet/widgets/fy_nepali_date_time_field.widget.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../../../../widgets/fy_date_time_field.widget.dart';
import '../../../../widgets/fy_dropdown.widget.dart';

class PayrollFilterView extends StatelessWidget {
  static String tag = 'payroll-filter-view';

  final Arguments? arguments;

  const PayrollFilterView(
    this.arguments, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<PayrollFilterModel>(
      onModelReady: (model) => model.init(arguments as PayrollFilterArguments),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Payroll Search'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    if (model.isNepaliDate == false)
                      _buildFieldForMonthlyReportFilter(model),
                    if (model.isNepaliDate == true)
                      _buildFieldForMonthlyNepaliReportFilter(model),
                    const SizedBox(
                      height: 10,
                    ),
                    if (model.isNepaliDate == false)
                      _buildFieldForWeeklyReportFilter(model),
                    if (model.isNepaliDate == true)
                      _buildFieldForNepaliWeekelyReportFilter(model),
                    const SizedBox(
                      height: 10,
                    ),
                    FYPrimaryButton(
                      label: "View Payroll",
                      onPressed: model.onViewPayrollPressed,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldForMonthlyReportFilter(PayrollFilterModel model) {
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
    PayrollFilterModel model) {
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

  Widget _buildFieldForWeeklyReportFilter(PayrollFilterModel model) {
    return Row(
      children: [
        Expanded(
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
        const SizedBox(width: 16),
        Expanded(
          child: FYDateField(
            title: "Date To",
            value: model.dateTo,
          ),
        ),
      ],
    );
  }

  Widget _buildFieldForNepaliWeekelyReportFilter(PayrollFilterModel model) {
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
