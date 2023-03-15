import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.model.dart';
import 'package:flex_year_tablet/ui/personal/holidays/widgets/holiday_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HolidaysView extends StatelessWidget {
  static String tag = 'holidays-view';

  const HolidaysView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<HolidaysModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Upcoming Holidays'),
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RefreshIndicator(
                    onRefresh: model.init,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final _holiday = HolidaysModel.filterHoliday[index];
                        DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                        DateTime date = dateFormat.parse(_holiday.date);

                        if (date.compareTo(DateTime.now()) < 0) {
                          return Container();
                        }

                        return HolidayItem(
                          holiday: _holiday,
                        );
                      },
                      itemCount: HolidaysModel.filterHoliday.length,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
