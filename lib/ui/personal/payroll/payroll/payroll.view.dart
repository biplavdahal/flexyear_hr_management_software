import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.model.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/widget/payroll_item.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.view.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_dropdown.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';

class PayrollView extends StatelessWidget {
  static String tag = 'payroll-view';

  final Arguments? arguments;

  const PayrollView(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<PayrollModel>(
      onModelReady: (model) => model.init(arguments as PayrollArgument),
      builder: (ctx, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Payroll Report'),
            ),
            floatingActionButton: model.isLoading
                ? null
                : FloatingActionButton(
                    onPressed: model.onSubmitPressed,
                    child: const Icon(Icons.search),
                    backgroundColor: AppColor.accent,
                  ),
            body: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopInfoBar(model),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildData(model)
                ],
              ),
            ));
      },
    );
  }

  Widget _buildTopInfoBar(PayrollModel model) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (model.payroll.isNotEmpty)
            Text(
              'Payroll report of ${getMonthStringFromDateString(model.searchParams['date_from'])}.',
              style: const TextStyle(color: AppColor.secondaryTextColor),
            ),
        ],
      ),
    );
  }

  Widget _buildData(PayrollModel model) {
    if (model.isLoading) {
      return const FYLinearLoader();
    } else if (model.payroll.isNotEmpty) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final _payroll = model.payroll[index];
          return PayrollItem(payroll: _payroll);
        },
        itemCount: model.payroll.length,
      );
    } else {
      return Expanded(
          child: Center(
        child: Image.asset(
          "assets/images/oops.png",
          width: 300,
        ),
      ));
    }
  }
}
