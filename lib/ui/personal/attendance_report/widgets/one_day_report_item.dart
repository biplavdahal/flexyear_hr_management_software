import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/attendance_one_day_report.data.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/attandance_report.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.view.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flutter/material.dart';

class OneDayReport extends StatelessWidget {
  final AttendanceOneDayReportData report;

  const OneDayReport({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Theme(
        data: getThemeDataTheme(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          iconColor: AppColor.primary,
          textColor: AppColor.primary,
          childrenPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          tilePadding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          title: Text(
            report.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Time In'),
                Text(report.timeIn),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Lunch In'),
                Text(report.lunchBreak),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Lunch Out'),
                Text(report.lunchBreakOut),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Time Out'),
                Text(report.timeOut),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Time'),
                Text(report.totalTime),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Lunch Time'),
                Text(report.lunchTime),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Grand Total'),
                Text(report.grandTotal),
              ],
            ),
            const Divider(),
            FYSecondaryButton(
              label: "View Summary",
              onPressed: () {
                locator<AttendanceReportModel>().goto(AttendanceSummaryView.tag,
                    arguments: AttendanceSummaryArguments(
                      date: report.date,
                      staffId: report.staffId.toString(),
                    ));
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
