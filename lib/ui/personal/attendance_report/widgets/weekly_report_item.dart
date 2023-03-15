import 'package:flex_year_tablet/data_models/attendance_weekly_report.data.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class WeeklyReportItem extends StatelessWidget {
  final AttendanceWeeklyReportData report;

  const WeeklyReportItem({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Employee name:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    report.name.trim(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all<Color>(
                AppColor.primary.withOpacity(0.16),
              ),
              columns: const [
                DataColumn(
                  label: Text('Weekday'),
                ),
                DataColumn(
                  label: Text('Working Hr.'),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    const DataCell(Text("Monday")),
                    DataCell(
                      Text(
                        report.monday,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              report.monday == "NS" ? Colors.red : Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("Tuesday")),
                    DataCell(
                      Text(
                        report.tuesday,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: report.tuesday == "NS"
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("Wednesday")),
                    DataCell(
                      Text(
                        report.wednesday,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: report.wednesday == "NS"
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("Thursday")),
                    DataCell(
                      Text(
                        report.thursday,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: report.thursday == "NS"
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("Friday")),
                    DataCell(
                      Text(
                        report.friday,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              report.friday == "NS" ? Colors.red : Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("Saturday")),
                    DataCell(
                      Text(
                        report.saturday,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: report.saturday == "NS"
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("Sunday")),
                    DataCell(
                      Text(
                        report.sunday,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              report.sunday == "NS" ? Colors.red : Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(
                      Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        report.totalWorkingHr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
