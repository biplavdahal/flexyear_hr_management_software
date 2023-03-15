import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/get_userstaff.data.dart';
import 'package:flex_year_tablet/data_models/leave_type.data.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.arguments.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_checkbox.widget.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_dropdown.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flutter/material.dart';

import '../../../helper/date_time_formatter.helper.dart';
import '../dashboard/dashboard.model.dart';

class WriteLeaveRequestView extends StatelessWidget {
  static String tag = 'write-leave-request-view';

  final Arguments? arguments;

  const WriteLeaveRequestView(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = locator<DashboardModel>().user;
    return View<WriteLeaveRequestModel>(
      onModelReady: (model) =>
          model.init(arguments as WriteLeaveRequestViewArguments?),
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              arguments != null
                  ? 'Update Leave Request'
                  : 'Create Leave Request',
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_user.role != 'staff')
                      const SizedBox(
                        height: 16,
                      ),
                    FYDropdown<LeaveTypeData>(
                      title: "Select Leave Type",
                      onChanged: model.onLeaveTypeChanged,
                      items: model.leaveTypes,
                      labels: model.leaveTypeLabels,
                      value: model.selectedLeaveTypeLabel!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FYDateField(
                      title: 'Leave Date From',
                      value: model.leaveDateFrom,
                      onChanged: (value) => model.leaveDateFrom = value,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FYDateField(
                      title: 'Leave Date Upto',
                      value: model.leaveDateUpto,
                      onChanged: (value) => model.leaveDateUpto = value,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (model.leaveDateFrom == model.leaveDateUpto)
                      FYCheckbox(
                        value: model.isHalfDayLeave,
                        onChanged: (value) => model.isHalfDayLeave = value!,
                        label: "Do you need half leave ?",
                      ),
                    if (model.isHalfDayLeave) ...[
                      const SizedBox(
                        height: 16,
                      ),
                      FYTimeField(
                        title: 'Leave time from',
                        value: model.leaveTimeFrom,
                        onChanged: (value) => model.leaveTimeFrom = value,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FYTimeField(
                        title: 'Leave time upto',
                        value: model.leaveTimeUpto,
                        onChanged: (value) => model.leaveTimeUpto = value,
                      ),
                    ],
                    const SizedBox(
                      height: 16,
                    ),
                    FYInputField(
                      title: '',
                      label: "Leave description",
                      controller: model.leaveDescriptionController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FYPrimaryButton(
                      label: "Submit request",
                      onPressed: model.onSubmitRequestPressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
