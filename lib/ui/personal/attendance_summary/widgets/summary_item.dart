import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.model.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.arguments.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.model.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.view.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';

class SummaryItem extends StatelessWidget {
  final AttendanceSummaryData summary;

  const SummaryItem(this.summary, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  summary.statusIn ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  summary.chekinDatetime ?? '-',
                  style: const TextStyle(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  summary.statusOut ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  summary.checkoutDatetime ?? '-',
                  style: const TextStyle(),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Hours",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(hourFormatter(summary.totalWorkedHour ?? '00:00:00')),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: FYPrimaryButton(
                label: "Request Review",
                onPressed: () {
                  locator<AttendanceSummaryModel>().goto(
                    RequestReviewView.tag,
                    arguments: RequestReviewArguments<AttendanceSummaryData>(
                      type: RequestReviewType.attendanceReview,
                      payload: summary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
