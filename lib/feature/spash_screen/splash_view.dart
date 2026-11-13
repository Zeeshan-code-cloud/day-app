import 'package:daymark/feature/spash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';

class SplashView extends GetView<SplashController> {
    const SplashView({super.key});


  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.darkBackgroundGradient,
          image: DecorationImage(image: AssetImage("assets/image/img1.png",),fit: BoxFit.cover)
        ),
        child: Stack(
          children: [

            /// Top Glow
            Positioned(
              top: -10.h,
              left: -20.w,
              child: Container(
                width: 60.w,
                height: 30.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: .55),
                      blurRadius: 120,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),

            /// Bottom Glow
            Positioned(
              bottom: -12.h,
              right: -15.w,
              child: Container(
                width: 100.w,
                height: 30.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withValues(alpha: .55),
                      blurRadius: 150,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    const Spacer(),

                    /// Logo
                    // Container(
                    //   height: 18.w,
                    //   width: 18.w,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: AppColors.primary.withValues(alpha: .8),
                    //         blurRadius: 100,
                    //         spreadRadius: 10,
                    //       ),
                    //     ],
                    //   ),
                    //   child: Center(
                    //     child: Image.asset(
                    //       "assets/icons/daymark_logo.png",
                    //       height: 18.w,
                    //       width: 18.w,
                    //     ),
                    //   ),
                    // ),



                    /// Mountains
                    Image.asset(
                      "assets/image/splashScreen.png",
                      width: 100.w,
                      fit: BoxFit.cover,
                    ),

                    /// App Name
                    AppText(
                      "DAYMARK",
                      type: AppTextType.xlSuperBold,
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      textAlign: TextAlign.center,
                      letterSpacing: 3,
                    ),

                    SizedBox(height: 1.5.h),

                    /// Subtitle
                    AppText(
                      "Build Consistency\nEvery Day",
                      type: AppTextType.body,
                      color: AppColors.darkTextSecondary,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),



                    SizedBox(height: 30.h),

                    /// Quote
                    AppText(
                      "A Better You\nStarts Today",
                      type: AppTextType.caption,
                      color: Colors.white.withValues(alpha: .9),
                      textAlign: TextAlign.center,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),

                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
