// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payroll.data.freezed.dart';
part 'payroll.data.g.dart';

@freezed
class PayrollData with _$PayrollData {
  const factory PayrollData({
    @JsonKey(name: 'staff_id') required String staffID,
    @JsonKey(name: 'end_date') required String endDate,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'middle_name') required String middleName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'gross_salary') required String grossSalary,
    @JsonKey(name: 'salary') required String salary,
    @JsonKey(name: 'salary_period') required String salaryPeriod,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'total_tax') required String totalTax,
    @JsonKey(name: 'working_salary') required String workingSalary,
  }) = _PayrollData;

  factory PayrollData.fromJson(Map<String, dynamic> json) =>
      _$PayrollDataFromJson(json);
}
