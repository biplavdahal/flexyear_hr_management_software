import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/attendance_correction_review.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.model.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.arguments.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.model.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../dashboard/dashboard.model.dart';

class CorrectionItem extends StatelessWidget {
  final AttendanceCorrectionReviewData correction;
  final ValueSetter<String> onDeletePressed;
  final ValueSetter<AttendanceCorrectionReviewData>? onEditTap;
  final ValueSetter<String>? onApprove;
  final ValueSetter<String>? onDecline;
  final bool isBusy;

  CorrectionItem({
    Key? key,
    required this.correction,
    this.isBusy = false,
    this.onApprove,
    this.onDecline,
    this.onEditTap,
    required this.onDeletePressed,
  }) : super(key: key);

  final Map<String, Color> _statusColor = {
    "P": Colors.yellow.shade300,
    'A': Colors.green.shade300,
    'D': Colors.red.shade200
  };

  @override
  Widget build(BuildContext context) {
    final _status = {"P": "Pending", "A": "Approved", "D": "Declined"};
    final _user = locator<DashboardModel>().user;
    return AbsorbPointer(
      absorbing: isBusy,
      child: AnimatedOpacity(
        duration: const Duration(microseconds: 300),
        opacity: isBusy ? 0.5 : 1,
        child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color:
                      _statusColor[correction.correctionStatus] ?? Colors.grey,
                  width: 1),
              borderRadius: BorderRadius.circular(10)),
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
                    Text(
                      correction.firstName + " " + correction.lastName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Text(
                    //   correction.checkinDatetime != null
                    //       ? formattedDate(correction.checkinDatetime!)
                    //       : "",
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    const SizedBox(width: 20),

                    if (_user.role != 'staff')
                      GestureDetector(
                        onTap:
                            _status[correction.correctionStatus] != "Approved"
                                ? () {
                                    onApprove?.call(correction.id);
                                  }
                                : null,
                        child: Icon(MdiIcons.check,
                            color: _status[correction.correctionStatus] !=
                                    "Approved"
                                ? Colors.green
                                : Colors.grey),
                      ),
                    if (_user.role != 'staff')
                      GestureDetector(
                        onTap: _status[correction.correctionStatus] != "P" ||
                                correction.checkinDatetime != 'A'
                            ? () {
                                onDecline?.call(correction.id);
                              }
                            : null,
                        child: Icon(MdiIcons.close,
                            color:
                                _status[correction.correctionStatus] == "P" ||
                                        correction.checkinDatetime != 'A'
                                    ? Colors.red
                                    : Colors.grey),
                      ),
                    Row(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.edit,
                            color: _status[correction.correctionStatus] ==
                                    "Pending"
                                ? AppColor.primary
                                : Colors.grey,
                          ),
                          onTap:
                              _status[correction.correctionStatus] == "Pending"
                                  ? () {
                                      locator<AttendanceCorrectionModel>().goto(
                                        RequestReviewView.tag,
                                        arguments: RequestReviewArguments<
                                            AttendanceCorrectionReviewData>(
                                          type: RequestReviewType.updateReview,
                                          payload: correction,
                                        ),
                                      );
                                    }
                                  : null,
                        ),
                        const SizedBox(width: 14),
                        GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: _status[correction.correctionStatus] ==
                                    "Pending"
                                ? Colors.redAccent
                                : Colors.grey,
                          ),
                          onTap:
                              _status[correction.correctionStatus] == "Pending"
                                  ? () {
                                      onDeletePressed(correction.id);
                                    }
                                  : null,
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
                        const DataCell(Text(
                          "CheckIn Date Time :",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )),
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
                        const DataCell(Text(
                          "CheckOut Date Time :",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )),
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
                        const DataCell(Text(
                          "CheckIn Request :",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )),
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
                        const DataCell(Text(
                          "CheckOut Request :",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )),
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
                        const DataCell(Text(
                          "Status :",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )),
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
      ),
    );
  }
}
