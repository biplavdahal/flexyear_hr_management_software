import 'package:flex_year_tablet/data_models/leave_request.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/widgets/fy_horizontal_list_view.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RequestItem extends StatelessWidget {
  final LeaveRequestData request;
  final bool isBusy;
  final ValueSetter<String>? onApprove;
  final ValueSetter<String>? onDecline;
  final ValueSetter<LeaveRequestData>? onEditTap;
  final ValueSetter<LeaveRequestData>? onDelete;

  const RequestItem(
      {Key? key,
      required this.request,
      this.isBusy = false,
      this.onApprove,
      this.onDecline,
      this.onDelete,
      this.onEditTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _status = {"0": "Pending", "1": "Approved", "2": "Declined"};

    final Map<String, Color> _statusColor = {
      "0": Colors.yellow.shade200,
      '1': Colors.green.shade200,
      '2': Colors.red.shade200
    };

    return AbsorbPointer(
      absorbing: isBusy,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: isBusy ? 0.5 : 1,
        child: Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: _statusColor[request.status] ?? Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _statusColor[request.status] ?? Colors.grey,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: Slidable(
                  startActionPane:
                      ActionPane(motion: const DrawerMotion(), children: [
                    SlidableAction(
                      padding: const EdgeInsets.all(2),
                      onPressed: (context) {
                        onEditTap?.call(request);
                      },
                      icon: Icons.edit,
                    ),
                    SlidableAction(
                      padding: const EdgeInsets.all(1),
                      onPressed: (context) {
                        onDelete?.call(request);
                      },
                      foregroundColor: Colors.red,
                      icon: Icons.delete,
                    )
                  ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      const SizedBox(width: 16),
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
                      const SizedBox(width: 16),
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
                    ],
                  ),
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
                          Text(
                            request.reason.isEmpty ? "Not Set" : request.reason,
                            style: request.reason.isEmpty
                                ? TextStyle(
                                    color: Colors.grey.shade400,
                                    fontStyle: FontStyle.italic,
                                  )
                                : null,
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
