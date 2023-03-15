import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.arguments.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';

class AttendanceSummaryModel extends ViewModel with SnackbarMixin {
  // Service
  final AttendanceService _attendanceService = locator<AttendanceService>();

  // Data
  late AttendanceSummaryArguments _summaryData;
  AttendanceSummaryArguments get summaryData => _summaryData;

  late List<AttendanceSummaryData> _summary;
  List<AttendanceSummaryData> get summary => _summary;

  // Actions
  Future<void> init(AttendanceSummaryArguments? arguments) async {
    try {
      _summaryData = arguments!;
      setIdle();
      setLoading();

      _summary = await _attendanceService.getAttendanceSummary(
        date: _summaryData.date,
        clientId: _summaryData.clientId,
        staffId: _summaryData.staffId,
      );

      setIdle();
    } catch (e) {
      goBack();
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: e.toString(),
        ),
      );
    }
  }
}
