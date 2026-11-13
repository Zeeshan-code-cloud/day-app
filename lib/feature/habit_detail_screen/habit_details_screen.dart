import 'package:daymark/core/app_pages/app_routes.dart';
import 'package:daymark/core/model/habit_model.dart';
import 'package:daymark/feature/habit_detail_screen/habit_details_screen_controller.dart';
import 'package:daymark/utils/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';

class HabitDetailsScreen extends GetView<HabitDetailsScreenController> {
  const HabitDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HabitModel habit = controller.habit;
    final color = Color(habit.colorValue);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1226),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            children: [
              /// Back
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              /// Habit Card
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1E35),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 6.h,
                      width: 6.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withOpacity(.2),
                      ),
                      child: Center(
                        child: Text(
                          _getCategoryEmoji(habit.category),
                          style: TextStyle(fontSize: 22.sp),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            AppText(
                              controller.titleC.text,
                              color: Colors.white,
                              type: AppTextType.heading3,
                            ),

                          SizedBox(height: .5.h),
                          Obx(
                            () =>  AppText(
                              controller.category.value,
                              color: AppColors.darkTextSecondary,
                              type: AppTextType.captionDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              /// Stats
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      value: "${habit.completedCount}",
                      title: "Completed",
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _statCard(
                      value: "${habit.streak}",
                      title: "Day Streak",
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              /// Info Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1E35),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "Details",
                      color: Colors.white,
                      type: AppTextType.heading3,
                    ),
                    SizedBox(height: 2.h),
                    _detailRow("Category", habit.category),
                    SizedBox(height: 1.5.h),
                    _detailRow("Created", _formatDate(habit.createdAt)),
                    SizedBox(height: 1.5.h),

                  ],
                ),
              ),



              SizedBox(height: 2.h),

              /// Actions
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1E35),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    _actionTile(
                      icon: Icons.edit_outlined,
                      title: "Edit Habit",
                      onTap: () async {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: const Color(0xFF0F1226),
                            title: AppText(
                              "Update title and category",
                              color: AppColors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            content: SizedBox(
                              height: 30.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppFormField(
                                    title: "Title",
                                    hintTextColor: AppColors.white,
                                    textEditingController: controller.titleC,
                                    borderColor: AppColors.border,
                                    showBorder: true,
                                    isFilled: true,
                                    textColor: AppColors.white,
                                    filledColor: Colors.transparent,
                                  ),
                                  SizedBox(height: 3.w),
                                  AppText("Update Category", fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.white,),
                                  SizedBox(height: 3.w),
                                  Wrap(
                                    children: List.generate(
                                      controller.categories.length,
                                      (int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.selectedC(index);
                                          },
                                          child: Obx(() {
                                            final selected =
                                                index ==
                                                controller.selectedC.value;
                                            return Container(
                                              padding: EdgeInsets.all(2.w),
                                              margin: EdgeInsets.all(1.w),
                                              decoration: BoxDecoration(
                                                gradient: selected
                                                    ? AppColors.buttonGradient
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: BoxBorder.all(
                                                  color: AppColors.textSecondary,
                                                ),
                                              ),
                                              child: AppText(
                                                controller
                                                    .categories[index]
                                                    .title,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(onPressed: () {
                                Get.back();
                              }, child: AppText("Cancel",color: AppColors.white,)),
                              ElevatedButton(onPressed: () {
                                controller.updateHabit();
                                Get.back();
                              }, child: AppText("Update"))
                            ],
                          ),
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


  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          label,
          color: AppColors.darkTextSecondary,
          type: AppTextType.body,
        ),
        AppText(value, color: Colors.white, type: AppTextType.body),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[date.month - 1]} ${date.day}, ${date.year}";
  }

  String _getCategoryEmoji(String category) {
    switch (category.toLowerCase()) {
      case 'health':
        return '🏃';
      case 'learning':
        return '📖';
      case 'productivity':
        return '⚡';
      case 'lifestyle':
        return '💧';
      case 'mindset':
        return '🧘';
      default:
        return '🎯';
    }
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: iconColor ?? Colors.white),
      title: AppText(title, color: textColor ?? Colors.white),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.sp,
        color: Colors.white54,
      ),
    );
  }

  Widget _bar(double height) {
    return Container(
      width: 4.w,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: .4),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }

  Widget _statCard({required String value, required String title}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1E35),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          AppText(
            value,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
          SizedBox(height: .5.h),
          AppText(
            title,
            color: AppColors.darkTextSecondary,
            type: AppTextType.captionDark,
          ),
        ],
      ),
    );
  }
}
