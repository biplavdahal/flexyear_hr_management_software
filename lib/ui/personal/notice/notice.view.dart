import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/data_models/holiday.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.model.dart';
import 'package:flex_year_tablet/ui/personal/holidays/widgets/holiday_item.dart';
import 'package:flex_year_tablet/ui/personal/notice/notice.viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/notice/widget/notice_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoticeView extends StatelessWidget {
  static String tag = 'notice-view';

  const NoticeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<NoticeModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Upcoming Notice'),
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RefreshIndicator(
                      onRefresh: model.init,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final _holiday = HolidaysModel.upcomingHoliday;
                          DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                          DateTime date = dateFormat.parse(_holiday.date);

                          if (date.compareTo(DateTime.now()) < 0) {
                            return Container();
                          }
                          if (HolidaysModel.upcomingHoliday == null) {
                            return const Center(
                              child: Text("No newer notice..... "),
                            );
                          }

                          return NoticeItem(
                            _holiday,
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 0,
                        ),
                        itemCount: 1,
                      )),
                ),
        );
      },
    );
  }
}
