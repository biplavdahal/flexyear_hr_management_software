import 'package:flex_year_tablet/data_models/payroll.data.dart';

abstract class PayrollService {
  ///Get all payroll Data
  Future<List<PayrollData>> getAllPayrolls({
    required Map<String, dynamic> data,
  });

  ///Action on payroll data
  Future<void> actionOnPayroll(
      {required String payrollid, required String action});
}
