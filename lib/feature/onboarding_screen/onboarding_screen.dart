import 'package:daymark/feature/onboarding_screen/onboarding_controller.dart';
import 'package:daymark/utils/app_colors.dart';
import 'package:daymark/utils/app_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/app_pages/app_routes.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(gradient: AppColors.darkBackgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 3.w),
            child: Column(
              children: [
                SizedBox(height: 6.w),
                SizedBox(
                  height: 75.h,
                  child: PageView.builder(
                    controller: controller.pageC,
                    onPageChanged: (index) {
                      controller.setIndex(index);
                    },
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    pageSnapping: true,
                    allowImplicitScrolling: true,
                    clipBehavior: Clip.none,
                    reverse: false,
                    dragStartBehavior: DragStartBehavior.start,
                    restorationId: null,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(height: 12.h,),
                          SizedBox(
                            height: 40.h,
                            width: double.infinity,
                            child: Image.asset(
                              controller.images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 13.w),
                          AppText(
                            controller.headings[index],
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5.w,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: AppText(
                              controller.captions[index],
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 23.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() {
                      if(controller.currentIndex.value != 0){
                        return GestureDetector(
                          onTap: (){
                            controller.pageC.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                          },
                          child: Container(
                            width: 12.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.buttonGradient
                            ),
                            child: Center(
                              child: Icon(Icons.arrow_left, color: Colors.white, size: 30.sp,),
                            ),
                          ),
                        );

                      }
                      return SizedBox(width: 12.w,);
                    }),
                    SizedBox(width: 12.w,),
                    Row(
                      children: List.generate(3, (index) {
                        return Obx(() {
                          return AnimatedContainer(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            duration: Duration(milliseconds: 150),
                            width: controller.currentIndex.value == index
                                ? 6.w
                                : 3.w,
                            height: 2.w,
                            decoration: BoxDecoration(
                              color: controller.currentIndex.value == index ? AppColors.primary : AppColors.textSecondary,
                            borderRadius: BorderRadius.circular(8)
                            ),
                          );
                        });
                      }),
                    ),
                     SizedBox(width: 12.w,),
                     Obx(() {
                       if(controller.currentIndex.value != 2){
                         return GestureDetector(
                           onTap: (){
                             controller.pageC.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                           },
                           child: Container(
                             width: 12.w,
                             height: 8.h,
                             decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 gradient: AppColors.buttonGradient
                             ),
                             child: Center(
                               child: Icon(Icons.arrow_right_outlined, color: Colors.white, size: 30.sp,),
                             ),
                           ),
                         );
                       }
                       else{
                         return GestureDetector(
                           onTap: controller.getStarted,
                           child: Container(
                            padding: EdgeInsets.all(3.w),
                             decoration: BoxDecoration(
                                  gradient: AppColors.buttonGradient,
                               borderRadius: BorderRadius.circular(12)
                             ),
                             child: Center(
                               child: AppText("Get Started", fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.white,)
                             ),
                           ),
                         );
                       }
                     })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
