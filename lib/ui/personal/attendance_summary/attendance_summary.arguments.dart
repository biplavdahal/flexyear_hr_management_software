import 'package:bestfriend/bestfriend.dart';

class AttendanceSummaryArguments extends Arguments {
  final String date;
  final String? clientId;
  final String? staffId;

  AttendanceSummaryArguments({
    required this.date,
    this.clientId,
    this.staffId,
  });
}
