import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/_test/test.view.dart';
import 'package:flex_year_tablet/ui/frontdesk/attendance/attendance.view.dart';
import 'package:flex_year_tablet/ui/frontdesk/enter_pin/enter_pin.view.dart';
import 'package:flex_year_tablet/ui/personal/add_attendance/add_attendance.view.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.view.dart';
import 'package:flex_year_tablet/ui/app_access_client_code/app_access_client_code.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction_review/attendance_correction_review.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/attendance_report.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.view.dart';
import 'package:flex_year_tablet/ui/personal/change_password/change_password_view.dart';
import 'package:flex_year_tablet/ui/personal/chat_contacts/chat_contacts.view.dart';
import 'package:flex_year_tablet/ui/personal/chats/chats.view.dart';
import 'package:flex_year_tablet/ui/personal/edit_profile/edit_profile.view.dart';
import 'package:flex_year_tablet/ui/personal/forget%20password/forget_password_view.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.view.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests_received/leave_request_received.view.dart';
import 'package:flex_year_tablet/ui/personal/notice/notice.view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.view.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.view.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.view.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.view.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.view.dart';
import 'package:flex_year_tablet/ui/personal/login/login.view.dart';
import 'package:flex_year_tablet/ui/personal/profile/profile.view.dart';
import 'package:flutter/material.dart';

Map<String, Widget> routesAndViews(RouteSettings settings) => {
      ForgetPasswordFragment.tag: const ForgetPasswordFragment(),
      ChangePasswordView.tag: const ChangePasswordView(),
      TestView.tag: const TestView(),
      EditProfileView.tag: const EditProfileView(),
      LoginView.tag: const LoginView(),
      AppAccessView.tag: const AppAccessView(),
      AppAccessClientCodeView.tag: const AppAccessClientCodeView(),
      DashboardView.tag: const DashboardView(),
      ProfileView.tag: const ProfileView(),
      HolidaysView.tag: const HolidaysView(),
      AttendanceCorrectionView.tag: const AttendanceCorrectionView(),
      LeaveRequestView.tag: const LeaveRequestView(),
      WriteLeaveRequestView.tag:
          WriteLeaveRequestView(settings.arguments as Arguments?),
      RequestReviewView.tag:
          RequestReviewView(settings.arguments as Arguments?),
      AttendanceReportView.tag:
          AttendanceReportView(settings.arguments as Arguments?),
      AttendanceReportFilterView.tag:
          AttendanceReportFilterView(settings.arguments as Arguments?),
      AttendanceSummaryView.tag:
          AttendanceSummaryView(settings.arguments as Arguments?),
      StaffsView.tag: StaffsView(settings.arguments as Arguments?),
      AttendanceCorrectionReviewView.tag:
          const AttendanceCorrectionReviewView(),
      LeaveRequestReceivedView.tag: const LeaveRequestReceivedView(),
      AddAttendanceView.tag: const AddAttendanceView(),
      EnterPinView.tag: const EnterPinView(),
      AttendanceView.tag: const AttendanceView(),
      ChatContactsView.tag: const ChatContactsView(),
      ChatsView.tag: ChatsView(settings.arguments as Arguments?),
      PayrollView.tag: PayrollView(settings.arguments as Arguments?),
      PayrollFilterView.tag:
          PayrollFilterView(settings.arguments as Arguments?),
      NoticeView.tag: const NoticeView(),
    };
