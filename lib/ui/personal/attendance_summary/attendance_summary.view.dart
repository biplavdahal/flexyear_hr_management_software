import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/widgets/summary_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AttendanceSummaryView extends StatelessWidget {
  static String tag = 'attendance-summary-view';

  final Arguments? arguments;

  const AttendanceSummaryView(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AttendanceSummaryModel>(
      onModelReady: (model) => model.init(
        arguments as AttendanceSummaryArguments,
      ),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                const Text('Attendance Summary'),
                Text(
                  formattedDate(model.summaryData.date),
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return SummaryItem(model.summary[index]);
                    },
                    itemCount: model.summary.length,
                  ),
                ),
        );
      },
    );
  }
}
