import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flutter/material.dart';
import '../data_models/staff.data.dart';
import '../theme.dart';

class UserAvatar extends StatelessWidget {
  final StaffData user;
  final File? tempImage;
  final double size;
  final double borderWidth;
  final Color borderColor;

  const UserAvatar({
    Key? key,
    required this.user,
    this.size = 24,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.tempImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tempImage != null) {
      return CircleAvatar(
        radius: size + borderWidth,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: size,
          backgroundColor: AppColor.primary.withOpacity(0.5),
          backgroundImage: FileImage(tempImage!),
        ),
      );
    }

    if (user.staffPhoto == null || user.staffPhoto == "") {
      return CircleAvatar(
        radius: size + borderWidth,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: size,
          backgroundColor: AppColor.primary.withOpacity(0.5),
          backgroundImage: const AssetImage("assets/images/avatar.png"),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: auImageBaseUrl + user.staffPhoto!,
      errorWidget: (context, url, error) => CircleAvatar(
        radius: size + borderWidth,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: size,
          backgroundColor: AppColor.primary.withOpacity(0.5),
          backgroundImage: const AssetImage("assets/images/avatar.png"),
        ),
      ),
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          radius: size + borderWidth,
          backgroundColor: borderColor,
          child: CircleAvatar(
            backgroundImage: imageProvider,
            radius: size,
            backgroundColor: AppColor.primary.withOpacity(0.5),
          ),
        );
      },
    );
  }
}
