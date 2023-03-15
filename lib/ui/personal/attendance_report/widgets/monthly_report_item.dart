import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class MonthlyReportItem extends StatelessWidget {
  final AttendanceReportData report;
  final VoidCallback? onTap;

  const MonthlyReportItem(
    this.report, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: report.weekend.isNotEmpty
              ? const Color.fromARGB(255, 139, 213, 245)
              : report.holiday != null
                  ? Colors.amber.shade100
                  : report.totalWorkingHours == '0.00' ||
                          report.totalWorkingHours == '00:00'
                      ? Colors.red.shade100
                      : Colors.green.shade100,
          width: 1.8,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                children: [
                  Text(
                    '${DateTime.parse(report.date).year}, ${getMonthStringFromDateString(report.date, shortten: true)}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    alignment: Alignment.center,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      report.date.substring(8, 10),
                      //OR
                      //report.date.split("-")[2];
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    weekDayFromDateString(report.date),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: VerticalDivider(
                color: Colors.grey.shade300,
                thickness: 0.75,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 12,
                  top: 16,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Check-in',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          report.checkInTime == '00:00'
                              ? '-'
                              : report.checkInTime,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Check-out',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          report.checkOutTime == '00:00'
                              ? '-'
                              : report.checkOutTime,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Hours',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          report.weekend.isNotEmpty
                              ? "Weekend"
                              : report.holiday != null
                                  ? "Holiday"
                                  : report.totalWorkingHours == '0.00' ||
                                          report.totalWorkingHours == '00:00'
                                      ? 'Absent'
                                      : report.totalWorkingHours,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: report.weekend.isNotEmpty
                                ? AppColor.primary
                                : report.holiday != null
                                    ? AppColor.primary
                                    : report.totalWorkingHours == '0.00' ||
                                            report.totalWorkingHours == '00:00'
                                        ? Colors.red
                                        : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
