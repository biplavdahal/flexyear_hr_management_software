import 'dart:convert';
import 'dart:io';

import 'package:bestfriend/bestfriend.dart';
import 'package:dio/dio.dart';
import 'package:flex_year_tablet/data_models/staff.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../managers/dialog/dialog.model.dart';
import '../../../services/user_service.dart';

class EditProfileViewModel extends ViewModel with DialogMixin, SnackbarMixin {
  //Service
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final UserService _userService = locator<UserService>();

  //UI components
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _firstnameController = TextEditingController();
  TextEditingController get firstnameController => _firstnameController;

  final TextEditingController _middlenameController = TextEditingController();
  TextEditingController get middlenameController => _middlenameController;

  final TextEditingController _lastnameController = TextEditingController();
  TextEditingController get lastnameController => _lastnameController;

  final TextEditingController _mobileController = TextEditingController();
  TextEditingController get mobileController => _mobileController;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _addressController = TextEditingController();
  TextEditingController get addressController => _addressController;

  // Data
  File? _newProfileImage;
  File? get newProfileImage => _newProfileImage;

  //Actions
  void init() {
    _firstnameController.text = _authenticationService.user!.staff.firstName;
    _middlenameController.text = _authenticationService.user!.staff.middleName;
    _lastnameController.text = _authenticationService.user!.staff.lastName;
    _mobileController.text = _authenticationService.user!.staff.mobile;
    _emailController.text = _authenticationService.user!.staff.email;
    setIdle();
  }

  Future<void> onChangeProfilePicturePressed() async {
    try {
      final _pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (_pickedFile != null) {
        _newProfileImage = File(_pickedFile.path);
        setIdle();
      }
    } catch (e) {
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: "Something went wrong!",
          type: ESnackbarType.error,
        ),
      );
    }
  }

  Future<void> onUpdatePressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        final currentData = locator<AuthenticationService>().user!.staff;

        final currentDataJson = currentData
            .copyWith(
                firstName: _firstnameController.text,
                middleName: _middlenameController.text,
                lastName: _lastnameController.text,
                email: _emailController.text,
                mobile: _mobileController.text)
            .toJson();

        dialog.showDialog(
          DialogRequest(type: DialogType.progress, title: "Updating..."),
        );
        if (_newProfileImage == null) {
          currentDataJson.remove("staff_photo");
        } else {
          currentDataJson["staff_photo"] =
              FileHelper.getBase64(_newProfileImage!);
        }
        await _userService.updateProfile(StaffData.fromJson(currentDataJson));

        dialog.hideDialog();
        snackbar.displaySnackbar(
          SnackbarRequest.of(
            message: "Profile updated!",
            type: ESnackbarType.success,
          ),
        );
      } on DioError catch (e) {
        dialog.hideDialog();

        snackbar.displaySnackbar(
          SnackbarRequest.of(
            message: e.toString(),
          ),
        );
      }
      goBack();
    }
  }
}

class FileHelper {
  static String getBase64(File file) {
    final bytes = file.readAsBytesSync();

    return "data:image/png;base64," + base64Encode(bytes);
  }
}
