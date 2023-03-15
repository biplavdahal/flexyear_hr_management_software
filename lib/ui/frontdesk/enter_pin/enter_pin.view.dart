import 'package:bestfriend/ui/view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/frontdesk/enter_pin/enter_pin.model.dart';
import 'package:flex_year_tablet/ui/frontdesk/enter_pin/widgets/input_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterPinView extends StatelessWidget {
  static String tag = 'enter-pin-view';

  const EnterPinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<EnterPinModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return SafeArea(
          child: Scaffold(
            body: Row(
              children: [
                _buildCompanyProfile(model, context: context),
                _buildPinInput(model, context: context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompanyProfile(
    EnterPinModel model, {
    required BuildContext context,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(2, 0),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: double.infinity,
              decoration: BoxDecoration(
                color: model.isOnline ? Colors.green : Colors.grey,
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                model.isOnline ? 'Online' : 'Offline',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              formattedTime(model.currentDateTime),
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "${formattedDate(model.currentDateTime)}, ${weekDayFromDateString(
                model.currentDateTime,
                shortten: false,
              )}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: auBaseURL + model.appAccessData.logo.logoPath,
                    width: 150,
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/flex_year_image.png',
                      width: 150,
                    ),
                    placeholder: (context, url) => const SizedBox(
                      width: 24,
                      height: 24,
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            if (model.lastSyncedDate != null)
              Text(
                "Last Synced: ${formattedDate(model.lastSyncedDate!)} ${formattedTime(model.lastSyncedDate!)}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPinInput(
    EnterPinModel model, {
    required BuildContext context,
  }) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your PIN',
                style: TextStyle(
                  fontSize: (MediaQuery.of(context).size.width * 0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please enter your PIN to continue',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: AbsorbPointer(
                  absorbing: true,
                  child: PinCodeTextField(
                    errorAnimationDuration: 1000,
                    boxShadows: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(2, 0),
                        blurRadius: 4,
                      ),
                    ],
                    hintCharacter: '#',
                    obscuringCharacter: "#",
                    blinkWhenObscuring: true,
                    appContext: context,
                    enabled: true,
                    length: 6,
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    obscureText: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      disabledColor: AppColor.primary.withOpacity(0.08),
                      borderWidth: 1,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 42,
                      fieldWidth: 42,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: model.pinController,
                    onCompleted: model.onPinEnterCompleted,
                    onChanged: (_) {},
                  ),
                ),
              ),
              for (int i = 0; i < 4; i++) ...[
                if (i < 4) const SizedBox(height: 24),
                Wrap(
                  spacing: 32,
                  children: [
                    for (int j = 0; j < 3; j++)
                      InputPin(
                        value: model.inputs[i][j],
                        onPressed: model.onInputCellPressed,
                      )
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
