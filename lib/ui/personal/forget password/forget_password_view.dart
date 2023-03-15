import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/login/login.model.dart';
import 'package:flex_year_tablet/ui/personal/login/login.view.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/fy_card.widget.dart';

class ForgetPasswordFragment extends StatelessWidget {
  const ForgetPasswordFragment({Key? key}) : super(key: key);
  static String tag = 'Forget-password-Fragment';

  @override
  Widget build(BuildContext context) {
    return View<LoginModel>(
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                color: AppColor.primary,
              ),
              _logo(),
              _forgetView(context, model),
              _forgetLogo(context, model)
            ],
          ),
          // body: SingleChildScrollView(
          //   physics: const NeverScrollableScrollPhysics(),
          //   child: Container(
          //     height: MediaQuery.of(context).size.width,
          //     decoration: const BoxDecoration(
          //         image: DecorationImage(
          //       image: AssetImage(
          //         "assets/images/forgot_password.png",
          //       ),
          //     )),
          //     child: Form(
          //       key: model.forgotPasswordFormKey,
          //       child: Column(
          //         children: [
          //           FYInputField(
          //             label: "Register Email",
          //             controller: model.forgotPasswordEmailController,
          //             keyboardType: TextInputType.emailAddress,
          //             validator: Validators().validateEmail,
          //           ),
          //           const SizedBox(
          //             height: 18,
          //           ),
          //           FYPrimaryButton(
          //             label: "Reset Password",
          //             onPressed: model.onForgotPasswordPressed,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}

Widget _logo() {
  return Align(
    alignment: Alignment.topCenter,
    child: SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Image.asset(
          "assets/images/flex_year_login_image.png",
          width: 150,
        ),
      ),
    ),
  );
}

Widget _forgetView(BuildContext context, LoginModel model) {
  return Align(
    alignment: Alignment.center,
    child: SafeArea(child: _forgetPassword(context, model)),
  );
}

Widget _forgetPassword(BuildContext context, LoginModel model) {
  return FYCard(
    elevation: 10,
    child: Form(
      key: model.forgotPasswordFormKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Please fill out your email.",
                style: TextStyle(color: AppColor.primary),
              ),
              const Text(
                "A Link to reset password will be sent there.",
                style: TextStyle(color: Colors.amber),
              ),
              const SizedBox(
                height: 10,
              ),
              FYInputField(
                title: 'check the email ',
                label: "Register Email",
                controller: model.forgotPasswordEmailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validators().validateEmail,
              ),
              const SizedBox(
                height: 10,
              ),
              FYPrimaryButton(
                label: "Reset Password",
                onPressed: () {
                  model.onForgotPasswordPressed();
                  if (model.onForgotPasswordPressed == 1) {
                    model.goto(LoginView.tag);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _forgetLogo(BuildContext context, LoginModel model) {
  return Align(
    child: Container(
      height: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width / 2.7,
          MediaQuery.of(context).size.width / 1.2),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/forgot_password.png"))),
    ),
  );
}
