import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/start_up/start_up.model.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class StartUpView extends StatelessWidget {
  static String tag = "start-up-view";

  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<StartUpModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          backgroundColor: AppColor.primary,
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/flex_year_login_image.png",
                  width: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                const FYLinearLoader(),
              ],
            ),
          ),
        );
      },
    );
  }
}
