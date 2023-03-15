import 'package:flex_year_tablet/data_models/attendance_correction_review.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ReviewItem extends StatelessWidget {
  final AttendanceCorrectionReviewData correction;
  final ValueSetter<String>? onApprove;
  final ValueSetter<String>? onDecline;
  final bool isProcessing;

  const ReviewItem({
    Key? key,
    required this.correction,
    required this.onApprove,
    required this.onDecline,
    this.isProcessing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _status = {
      "P": "Pending",
      "D": "Declined",
      "A": "Approved",
    };

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isProcessing ? 0.5 : 1,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        correction.firstName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        correction.checkinDatetime != null
                            ? formattedDate(correction.checkinDatetime!)
                            : "",
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          MdiIcons.check,
                          color:
                              _status[correction.correctionStatus] == 'Approved'
                                  ? Colors.grey
                                  : Colors.green,
                        ),
                        onTap:
                            _status[correction.correctionStatus] == 'Approved'
                                ? null
                                : () {
                                    onApprove!(correction.id);
                                  },
                      ),
                      const SizedBox(width: 14),
                      GestureDetector(
                        child: Icon(
                          MdiIcons.cancel,
                          color:
                              _status[correction.correctionStatus] == 'Declined'
                                  ? Colors.grey
                                  : Colors.red,
                        ),
                        onTap:
                            _status[correction.correctionStatus] == 'Declined'
                                ? null
                                : () {
                                    onDecline!(correction.id);
                                  },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                headingRowHeight: 0,
                columns: const [
                  DataColumn(label: Text("")),
                  DataColumn(label: Text("")),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(Text("In Request Time")),
                      DataCell(
                        Text(
                          correction.checkinDatetime != null
                              ? formattedTime(correction.checkinDatetime!)
                              : "N/A",
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("Out Request Time")),
                      DataCell(
                        Text(
                          correction.checkoutDatetime != null
                              ? formattedTime(correction.checkoutDatetime!)
                              : "N/A",
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("In Time")),
                      DataCell(
                        Text(
                          correction.checkinDatetimeRequest != null
                              ? formattedTime(
                                  correction.checkinDatetimeRequest!)
                              : "N/A",
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("Out Time")),
                      DataCell(
                        Text(
                          correction.checkoutDatetimeRequest != null
                              ? formattedTime(
                                  correction.checkoutDatetimeRequest!)
                              : "N/A",
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("Status")),
                      DataCell(
                        Text(
                          _status[correction.correctionStatus]!,
                          style: TextStyle(
                            color: _status[correction.correctionStatus] ==
                                    "Pending"
                                ? Colors.orange
                                : _status[correction.correctionStatus] ==
                                        "Approved"
                                    ? Colors.green
                                    : Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
