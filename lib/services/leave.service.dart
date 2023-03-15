import 'package:flex_year_tablet/data_models/leave_request.data.dart';

abstract class LeaveService {
  /// Create new leave
  Future<void> createLeaveRequest(Map<String, dynamic> leaveData);

  /// Update leave request by cliet or Staff
  Future<void> updateLeaveRequest(Map<String, dynamic> leaveData);

  /// Get all leave requests
  Future<List<LeaveRequestData>> getAllLeaveRequests([bool self = true]);

  /// Delete leave request
  Future<void> deleteLeaveRequest(
    String id,
  );

  /// Action on leave request
  Future<void> actionOnLeaveRequest({
    required String requestId,
    required String action,
  });
}
