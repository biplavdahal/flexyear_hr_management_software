import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/helper/fy_validator.helper.dart';
import 'package:flex_year_tablet/ui/app_access_client_code/app_access_client_code.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AppAccessClientCodeView extends StatelessWidget {
  static String tag = 'app-access-client-code-view';

  const AppAccessClientCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AppAccessClientCodeModel>(
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('App Client Code'),
          ),
          body: Column(
            children: [
              if (model.isLoading) const FYLinearLoader(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                          "Enter client code or the frontdesk code to acc ess the app"),
                      const SizedBox(height: 16),
                      FYInputField(
                        title: '',
                        label: 'Enter client/frontdesk code',
                        controller: model.codeController,
                        validator: FYValidator.isRequired,
                      ),
                      const SizedBox(height: 16),
                      FYPrimaryButton(
                          label: 'Submit', onPressed: model.onSubmit),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
