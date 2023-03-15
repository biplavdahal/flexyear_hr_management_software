import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.model.dart';

class AttendanceReportFilterArguments extends Arguments {
  final AttendanceReportFilterType type;
  final bool returnBack;

  AttendanceReportFilterArguments({
    required this.type,
    this.returnBack = false,
  });
}
