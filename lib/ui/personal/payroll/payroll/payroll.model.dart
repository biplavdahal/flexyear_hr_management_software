import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/payroll.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/payroll.service.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.view.dart';
import 'package:flutter/material.dart';

class PayrollModel extends ViewModel with SnackbarMixin, DialogMixin {
  //Service
  final PayrollService _payrollService = locator<PayrollService>();

  //Data
  late Map<String, dynamic> _searchParams;
  Map<String, dynamic> get searchParams => _searchParams;

  List<PayrollData> _payrolls = [];
  List<PayrollData> get payroll => _payrolls;

  Future<void> init(PayrollArgument argument) async {
    _searchParams = argument.searchParams;
    setIdle();

    try {
      setLoading();

      _payrolls = await _payrollService.getAllPayrolls(data: _searchParams);
      setSuccess();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onSubmitPressed() async {
    final response = await goto(PayrollFilterView.tag,
        arguments: PayrollFilterArguments(returnBack: false));

    if (response != null) {
      init(response);
    }
  }
}
