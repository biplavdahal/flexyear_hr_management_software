import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/frontdesk/attendance/attendance.model.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/attendance_button.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AttendanceView extends StatelessWidget {
  static String tag = 'attendance-view';

  const AttendanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AttendanceModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Welcome ${model.loggedInAs.username}'),
          ),
          floatingActionButton:
              model.loggedInAs.accessLevel != "0" && model.isOnline
                  ? FYPrimaryButton(
                      label: 'Sync with Server',
                      onPressed: model.onSyncAttendancePressed,
                      backgroundColor: Colors.green,
                    )
                  : null,
          body: model.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Your attendance status is : ",
                            children: [
                              TextSpan(
                                text: model.attendanceStatus.checkIn == 1
                                    ? "Check Out"
                                    : model.attendanceStatus.lunchOut == 1
                                        ? "Lunch In"
                                        : "Check In",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: model.attendanceStatus.checkIn == 1
                                      ? Colors.red
                                      : model.attendanceStatus.lunchOut == 1
                                          ? Colors.green
                                          : Colors.blue,
                                ),
                              ),
                            ],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(height: 24),
                        GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          childAspectRatio: 3.5,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          children: [
                            AttendanceButton(
                              titles: '',
                              isTablet: true,
                              title: "Check In",
                              icon: MdiIcons.clockStart,
                              color: Colors.green,
                              onPressed: model.attendanceStatus.checkIn == 1
                                  ? () {
                                      model
                                          .onAttendanceButtonPressed('checkin');
                                    }
                                  : null,
                            ),
                            AttendanceButton(
                              titles: '',
                              isTablet: true,
                              title: "Check Out",
                              icon: MdiIcons.clockEnd,
                              color: Colors.green,
                              onPressed: model.attendanceStatus.checkOut == 1
                                  ? () {
                                      model.onAttendanceButtonPressed(
                                          'checkout');
                                    }
                                  : null,
                            ),
                            AttendanceButton(
                              titles: '',
                              isTablet: true,
                              title: "Lunch In",
                              icon: MdiIcons.food,
                              color: AppColor.primary,
                              onPressed: model.attendanceStatus.lunchIn == 1
                                  ? () {
                                      model
                                          .onAttendanceButtonPressed('lunchin');
                                    }
                                  : null,
                            ),
                            AttendanceButton(
                              titles: '',
                              isTablet: true,
                              title: "Lunch Out",
                              icon: MdiIcons.foodOff,
                              color: AppColor.primary,
                              onPressed: model.attendanceStatus.lunchOut == 1
                                  ? () {
                                      model.onAttendanceButtonPressed(
                                          'lunchout');
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
