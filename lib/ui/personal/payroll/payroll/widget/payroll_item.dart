import 'package:flex_year_tablet/data_models/attendance_correction_review.data.dart';
import 'package:flex_year_tablet/data_models/payroll.data.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class PayrollItem extends StatelessWidget {
  final PayrollData payroll;
  final ValueSetter<String>? onDeletePressed;
  final ValueSetter<AttendanceCorrectionReviewData>? onEditTap;
  final ValueSetter<String>? onApprove;
  final ValueSetter<String>? onDecline;
  final bool isBusy;

  PayrollItem({
    Key? key,
    required this.payroll,
    this.isBusy = false,
    this.onApprove,
    this.onDecline,
    this.onEditTap,
    this.onDeletePressed,
  }) : super(key: key);

  final Map<String, Color> _statusColor = {
    "1": Colors.green.shade300,
    "0": Colors.red.shade200
  };

  @override
  Widget build(BuildContext context) {
    final _status = {"1": "Paid", "0": "Unpaid"};
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
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
                subtitle: Text(
                  'Salary: ${payroll.salary}',
                  style: TextStyle(color: _statusColor[payroll.status]),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          payroll.firstName + " " + payroll.lastName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () async{
                          
                        
                          },
                          child: const Icon(
                            Icons.file_download,
                            color: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Basic Salary"),
                      Text(payroll.salary),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Start Date'),
                      Text(payroll.startDate),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Addition'),
                      Text("Null"),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Deduction'),
                      Text("Null"),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('End Date'),
                      Text(payroll.endDate),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Gross Salary'),
                      Text(payroll.grossSalary),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Tax'),
                      Text(payroll.totalTax),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status'),
                      Text(
                        _status[payroll.status]!,
                        style: TextStyle(
                            color: _status[payroll.status] == "Paid"
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const Divider()
                ])));
  }
}
