import 'package:flex_year_tablet/data_models/holiday.data.dart';
import 'package:flex_year_tablet/widgets/fy_section.widget.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../theme.dart';

class NoticeItem extends StatelessWidget {
  final HolidayData notice;
  const NoticeItem(this.notice, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int daysRemaining =
        DateTime.parse(notice.date).difference(DateTime.now()).inDays;
    return FYSection(
      title: "Upcoming Holiday:",
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          MdiIcons.calendar,
                          color: AppColor.secondaryTextColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          notice.date,
                          style: const TextStyle(
                            color: AppColor.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      notice.title,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$daysRemaining day${daysRemaining > 1 ? 's' : ''} remaining',
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/images/ic_launcher_adaptive_fore.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  height: 90,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.center,
                        colors: [
                          Colors.white,
                          Colors.white10,
                        ]),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
