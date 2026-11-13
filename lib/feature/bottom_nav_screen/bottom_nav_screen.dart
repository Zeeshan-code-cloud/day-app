import 'package:daymark/feature/bottom_nav_screen/bottom_nav_controller.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../utils/show_custom_dialog.dart';

class  BottomNavScreen extends GetView<BottomNavController> {
  const  BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result){
        if(didPop){
          return;
        }
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

      child: Scaffold(

        body: Obx(
                () {

              return  IndexedStack(
                index: controller.currentIndex.value,
                children: controller.pages
                    .map((page) => page)
                    .toList(),
              );
            }
        ),

        bottomNavigationBar: Obx(() {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 1.h,
                ),
                decoration: BoxDecoration(
                 gradient: AppColors.darkBackgroundGradient,

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(
                      index: 0,
                      title: "Home",
                      icon:  controller.currentIndex.value == 0 ?  "assets/icons/homeIcon.svg" :  "assets/icons/homeIconsOutlines.svg",
                    ),
                    _navItem(
                      index: 1,
                      title: "Collection",
                      icon: controller.currentIndex.value == 1 ?  "assets/icons/historyicons.svg" : "assets/icons/historyIconoutlines.svg",
                    ),
                    _navItem(
                      index: 2,
                      title: "Setting",
                      icon: controller.currentIndex.value == 2  ? "assets/icons/settingIcons.svg" :  "assets/icons/settingIconOutline.svg",
                    ),

                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required String title,
    required String icon,
  }) {
    final bool isSelected = controller.currentIndex.value  == index;

    return GestureDetector(
      onTap: () {
        controller.setIndex(index);

      },
      child:  SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              height: 3.4.h,
              width: 6.4.h,

            ),

            SizedBox(height: .5.h),

            AppText(
              title,
              type: AppTextType.micro,
              color: isSelected
                  ? Colors.white
                  : AppColors.textSecondary,
              fontWeight: isSelected
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
