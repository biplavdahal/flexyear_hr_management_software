import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_section.widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/fy_input_field.widget.dart';
import 'change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  static String tag = "change-password-view";

  @override
  Widget build(BuildContext context) {
    return View<ChangePasswordViewModel>(
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Change Password'),
            ),
            body: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildNote(model), _buildBody(model)],
                  ),
                )));
      },
    );
  }

  Widget _buildNote(ChangePasswordViewModel model) {
    return FYSection(
      infoBox: true,
      title: "Choose a strong password by following these rules:",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text("1. Password must contain at least 8 character. "),
          Text(""),
          Text(
              "2. Password must contain alpha-numeric value with at least 1 character, 1 number and 1 special character.")
        ],
      ),
    );
  }

  Widget _buildBody(ChangePasswordViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: model.formKey,
        child: Column(
          children: [
            FYInputField(
              title: '',
              label: "Current Pasword",
              controller: model.oldPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 10),
            FYInputField(
              title: '',
              label: "New Password",
              controller: model.newPasswordController,
              validator: Validators.validatePassword,
              obscureText: true,
            ),
            const SizedBox(height: 10),
            FYInputField(
              title: '',
              label: "Confirm New Password",
              obscureText: true,
              controller: model.confirmPasswordController,
              validator: (confirm) => Validators.validateConfirmPassword(
                  confirm, model.newPasswordController.text),
              isPassword: true,
            ),
            const SizedBox(height: 10),
            FYSecondaryButton(
                label: "Proceed", onPressed: model.onSetNewPasswordPressed),
            const SizedBox(height: 10),
            FYSecondaryButton(
              label: "Cancel",
              onPressed: model.onCancelPressed,
            ),
            const Text(
                "Note: Please make sure that you want to change your password.")
          ],
        ),
      ),
    );
  }
}
