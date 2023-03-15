import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.model.dart';

class AttendanceReportArguments extends Arguments {
  final AttendanceReportFilterType type;
  final Map<String, dynamic> searchParams;

  AttendanceReportArguments({
    required this.type,
    required this.searchParams,
  });
}
