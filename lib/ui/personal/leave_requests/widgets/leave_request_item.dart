import 'package:bestfriend/di.dart';
import 'package:flex_year_tablet/data_models/leave_request.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../dashboard/dashboard.model.dart';

class LeaveRequestItem extends StatelessWidget {
  final LeaveRequestData request;
  final bool isBusy;
  final ValueSetter<String>? onRemoveTap;
  final ValueSetter<LeaveRequestData>? onEditTap;
  final ValueSetter<String>? onApprove;
  final ValueSetter<String>? onDecline;

  LeaveRequestItem(
      {Key? key,
      required this.request,
      this.isBusy = false,
      this.onRemoveTap,
      this.onApprove,
      this.onEditTap,
      this.onDecline})
      : super(key: key);

  final Map<String, Color> _statusColor = {
    "0": Colors.yellow.shade300,
    '1': Colors.green.shade300,
    '2': Colors.red.shade200
  };

  @override
  Widget build(BuildContext context) {
    final _user = locator<DashboardModel>().user;
    final _status = {"0": "Pending", "1": "Approved", "2": "Declined"};
    return AbsorbPointer(
      absorbing: isBusy,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isBusy ? 0.5 : 1,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: _statusColor[request.status] ?? Colors.red.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_user.role == 'staff')
                      Expanded(
                        child: Text(
                          request.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    if (_user.role != 'staff')
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.staffName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              request.title,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(width: 15),
                    if (_user.role != 'staff')
                      GestureDetector(
                        onTap: _status[request.status] != "Approved"
                            ? () {
                                onApprove?.call(request.id);
                              }
                            : null,
                        child: Icon(
                          MdiIcons.check,
                          color: _status[request.status] != "Approved"
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                    if (_user.role != 'staff') const SizedBox(width: 15),
                    if (_user.role != 'staff')
                      GestureDetector(
                        onTap: _status[request.status] != "Approved" ||
                                request.checkedBy != '0'
                            ? () {
                                onDecline?.call(request.id);
                              }
                            : null,
                        child: Icon(
                          MdiIcons.close,
                          color: _status[request.status] == "Approved" ||
                                  request.checkedBy != '0'
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    if (_user.role != 'staff') const SizedBox(width: 15),
                    GestureDetector(
                      onTap: request.status == "0"
                          ? () {
                              onEditTap?.call(request);
                            }
                          : null,
                      child: Icon(
                        Icons.edit,
                        color: request.status == "0"
                            ? AppColor.primary
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: request.status == "0"
                          ? () {
                              onRemoveTap?.call(request.id);
                            }
                          : null,
                      child: Icon(
                        MdiIcons.delete,
                        color: request.status == "0" ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  headingRowHeight: 0,
                  dividerThickness: 0,
                  horizontalMargin: 10,
                  columns: const [
                    DataColumn(
                      label: Text(""),
                    ),
                    DataColumn(
                      label: Text(""),
                    ),
                  ],
                  rows: [
                    if (request.totalHours == "00:00:00")
                      DataRow(
                        cells: [
                          const DataCell(
                            Text(
                              "Total Days",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              "${request.numberOfDays} Day(s)\n(${request.dateFrom} - ${request.dateTo})",
                              style: const TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (request.totalHours != "00:00:00")
                      DataRow(
                        cells: [
                          const DataCell(
                            Text(
                              "Total Hours",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              "${request.totalHours != null ? hourFormatter(request.totalHours!) : '-'}\n(${request.fromTime} - ${request.toTime})",
                              style: const TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    DataRow(
                      cells: [
                        const DataCell(
                          Text(
                            "Requested On",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            formattedDate(request.requestedDate),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        const DataCell(
                          Text(
                            "Reason",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(request.reason
                              // request.reason.isEmpty ? "Not Set" : request.reason,
                              // style: request.reason.isEmpty
                              //     ? TextStyle(
                              //         color: Colors.grey.shade400,
                              //         fontStyle: FontStyle.italic,
                              //       )
                              //     : null,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
