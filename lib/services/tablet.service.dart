import 'package:flex_year_tablet/data_models/attendance_status.data.dart';
import 'package:flex_year_tablet/data_models/pin.data.dart';

abstract class TabletService {
  List<PinData> get pins;

  PinData? get loggedInAs;
  set loggedInAs(PinData? pin);

  Future<void> loadPins();

  Future<AttendanceStatusData> attendanceStatus();

  Future<AttendanceStatusData> postAttendanceStatus({
    required String status,
  });

  Future<AttendanceStatusData> postAttedanceStatusLocally({
    required String status,
  });

  Future<void> syncAttendancesWithServer(List attendances);
}
