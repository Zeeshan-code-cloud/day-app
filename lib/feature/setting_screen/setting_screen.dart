import 'package:daymark/feature/setting_screen/setting_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../utils/show_custom_dialog.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1226),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Title
              AppText(
                "Settings",
                type: AppTextType.heading1,
                color: Colors.white,
              ),

              SizedBox(height: 3.h),

              /// Profile Card


              /// Settings Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1E35),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Divider(
                      color: Colors.white.withOpacity(.05),
                      height: 0,
                    ),

                    Divider(
                      color: Colors.white.withOpacity(.05),
                      height: 0,
                    ),

                    _settingsTile(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy Policy",
                      onTap: () async  {
                        await controller.launchToWeb("https://zeeshan-code-cloud.github.io/dayMark-privacy-policy/");
                      },
                    ),

                    Divider(
                      color: Colors.white.withOpacity(.05),
                      height: 0,
                    ),

                    _settingsTile(
                      icon: Icons.newspaper,
                      title: "Term and Conditions",
                      trailing: "v1.0.0",
                      onTap: () async  {
                        await controller.launchToWeb("https://zeeshan-code-cloud.github.io/dayMark-term-conditions/");
                      },
                    ),

                    Divider(
                      color: Colors.white.withOpacity(.05),
                      height: 0,
                    ),
                    _settingsTile(
                      icon: Icons.question_mark,
                      title: "About App",
                      trailing: "v1.0.0",
                      onTap: () async {
                        await controller.launchPlayStore("com.zeetechapp.app.daymark");
                      },
                    ),

                    Divider(
                      color: Colors.white.withOpacity(.05),
                      height: 0,
                    ),

                    _settingsTile(
                      icon: Icons.logout,
                      iconColor: Colors.redAccent,
                      textColor: Colors.redAccent,
                      title: "Exit App",
                      onTap: () {
                        ShowCustomDialog.showCustomDialog(
                          context: context,
                          icon: Icons.exit_to_app_rounded,
                          iconColor: Colors.orange,
                          title: "Exit App?",
                          content: "Are you sure you want to close the application?",
                          cancelText: "Stay",
                          confirmText: "Exit",
                          confirmButtonColor: Colors.orange,
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            Navigator.pop(context);
                            SystemNavigator.pop();
                          },
                        );

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _settingsTile({
    required IconData icon,
    required String title,
    String? trailing,
    VoidCallback? onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      onTap: onTap,

      leading: Icon(
        icon,
        color: iconColor ?? Colors.white,
        size: 20.sp,
      ),

      title: AppText(
        title,
        color: textColor ?? Colors.white,
        type: AppTextType.body,
      ),

      trailing: trailing != null
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            trailing,
            color: AppColors.darkTextSecondary,
            type: AppTextType.captionDark,
          ),
          SizedBox(width: 2.w),
          Icon(
            Icons.arrow_forward_ios,
            size: 14.sp,

            color: Colors.white38,
          ),
        ],
      )
          : Icon(
        Icons.arrow_forward_ios,
        size: 14.sp,
        color: Colors.white38,
      ),
    );
  }
}
