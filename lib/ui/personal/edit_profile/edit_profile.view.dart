import 'package:bestfriend/bestfriend.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../helper/fy_validator.helper.dart';
import '../../../services/authentication.service.dart';
import '../../../theme.dart';
import '../../../widgets/fy_button.widget.dart';
import '../../../widgets/fy_input_field.widget.dart';
import '../../../widgets/fy_user_avatar_widget.dart';
import 'edit_profile.viewmodel.dart';

class EditProfileView extends StatelessWidget {
  static String tag = 'edit-profile-view';

  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<EditProfileViewModel>(
      enableTouchRepeal: true,
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          backgroundColor: AppColor.primary,
          appBar: AppBar(),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: model.onChangeProfilePicturePressed,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      UserAvatar(
                        user: locator<AuthenticationService>().user!.staff,
                        tempImage: model.newProfileImage,
                        size: 50,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            MdiIcons.camera,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: model.formKey,
                        child: Column(
                          children: [
                            FYInputField(
                              title: '',
                              label: "First Name",
                              controller: model.firstnameController,
                              validator: FYValidator.isRequired,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FYInputField(
                              title: '',
                              label: "Middle Name",
                              controller: model.middlenameController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FYInputField(
                              title: '',
                              label: "Last Name",
                              controller: model.lastnameController,
                              validator: FYValidator.isRequired,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FYInputField(
                              title: '',
                              label: "Mobile Number",
                              controller: model.mobileController,
                              validator: FYValidator.isRequired,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FYInputField(
                              title: '',
                              label: "Email Address",
                              controller: model.emailController,
                              validator: FYValidator.isRequired,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FYPrimaryButton(
                                label: "Submit request",
                                onPressed: model.onUpdatePressed)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
