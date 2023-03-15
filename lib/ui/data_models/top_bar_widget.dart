import 'package:flex_year_tablet/ui/data_models/top_dar_data.dart';
import 'package:flutter/material.dart';
import 'package:bestfriend/bestfriend.dart';

class TopBar extends StatelessWidget {
  final TopBarData data;
  final VoidCallback onBackPressed;
  final VoidCallback onOTPPressed;
  final VoidCallback onNewPasswordPressed;

  const TopBar({
    Key? key,
    required this.data,
    required this.onBackPressed,
    required this.onOTPPressed,
    required this.onNewPasswordPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 42.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.enableBack)
                  GestureDetector(
                    onTap: onBackPressed,
                    child: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.white,
                    ),
                  )
                else
                  Image.asset(
                    "assets/images/forgot_password.png",
                    height: 42.h,
                    color: Colors.white,
                  ),
                const Spacer(),
                if (!data.enableBack)
                  linkText(
                    "Enter OTP",
                    isActive: data.activeOTP,
                    onPressed: onOTPPressed,
                  ),
                if (!data.enableBack) const SizedBox(width: 8),
                if (!data.enableBack)
                  linkText(
                    "Change Password",
                    isActive: data.activeNewPasword,
                    onPressed: onNewPasswordPressed,
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            data.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            data.subtitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget linkText(String text,
      {required bool isActive, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: isActive ? null : onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
