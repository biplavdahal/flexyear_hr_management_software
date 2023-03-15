import 'package:flex_year_tablet/data_models/attendance_report_summary.data.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class MonthlyHorizontalReportItem extends StatelessWidget {
  final AttendanceReportSummaryData report;
  final VoidCallback? onTap;

  const MonthlyHorizontalReportItem(
    this.report, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        iconColor: AppColor.primary,
        textColor: AppColor.primary,
        childrenPadding: const EdgeInsets.only(left: 16, right: 16),
        tilePadding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  report.fullName.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total no. of days:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(report.totalDays.toString())
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total no. of holidays:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(report.offDay.toString()),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total no. of working days:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(report.workingdays.toString()),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total no. of present days:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(report.present.toString()),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total no. of absent days:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(report.absent.toString()),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total no. of requested leave days:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(report.leaveTotal.toString()),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total no. of working hours:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(report.workingHours.toString())
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
