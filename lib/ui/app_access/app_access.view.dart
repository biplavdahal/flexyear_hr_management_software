import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AppAccessView extends StatelessWidget {
  static String tag = 'app-access-view';

  const AppAccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AppAccessModel>(
      onModelReady: (model) => model.init(),
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 64 + 50,
                  left: 64,
                  right: 64,
                  bottom: 64,
                ),
                color: AppColor.primary,
                width: double.infinity,
                child: model.appAccess == null
                    ? Image.asset(
                        'assets/images/flex_year_login_image.png',
                        width: 150,
                      )
                    : Image.network(auBaseURL + model.appAccess!.logo.logoPath),
              ),
              if (model.isLoading) const FYLinearLoader(),
              if (model.appAccess != null)
                _buildAppUsageSelection(model)
              else
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: model.appAccessFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Enter the assigned access key",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FYInputField(
                            title: '',
                            label: "Enter app access",
                            controller: model.appAccessController,
                          ),
                          const SizedBox(height: 20),
                          FYPrimaryButton(
                            label: "Verify Key",
                            onPressed: model.isLoading
                                ? null
                                : model.onVerifyKeyPressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppUsageSelection(AppAccessModel model) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Text('Company: ${model.appAccess!.company.companyName}'),
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "How is this app suppose to be used?",
                    style: TextStyle(
                        color: AppColor.primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FYPrimaryButton(
                    label: 'Personal Use',
                    onPressed: () {
                      model.onUsagesPressed("PERSONAL");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FYPrimaryButton(
                    label: 'Frontdesk Use',
                    onPressed: () {
                      model.onUsagesPressed("FRONTDESK");
                    },
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          TextButton.icon(
            icon: const Icon(Icons.reset_tv),
            onPressed: model.onResetPressed,
            label: const Text("Reset Company"),
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
