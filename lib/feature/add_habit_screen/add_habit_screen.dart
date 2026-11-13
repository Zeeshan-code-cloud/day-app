import 'package:daymark/feature/add_habit_screen/add_habit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_field.dart';

class AddHabitScreen extends GetView<AddHabitController> {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1226),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 6.w,
            vertical: 2.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Back Button
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),

              SizedBox(height: 3.h),

              AppText(
                "Create New Habit",
                type: AppTextType.heading1,
                color: Colors.white,
              ),

              SizedBox(height: 4.h),

              /// Habit Name
              AppText(
                "Habit Name",
                color: Colors.white,
                type: AppTextType.body,
              ),

              SizedBox(height: 1.h),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2140),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: AppFormField(
                  title: "e.g. Read a book",
                  textEditingController: controller.habitController,
                  showBorder: false,
                  isFilled: true,
                  filledColor: Colors.transparent,
                  textColor: Colors.white,
                  hintTextColor: AppColors.darkTextSecondary,
                ),
              ),

              SizedBox(height: 3.h),

              /// Category
              AppText(
                "Category",
                color: Colors.white,
                type: AppTextType.body,
              ),

              SizedBox(height: 1.5.h),

              Obx(
                    () => Wrap(
                  spacing: 3.w,
                  runSpacing: 1.5.h,
                  children: List.generate(
                    controller.categories.length,
                        (index) {
                      final category =
                      controller.categories[index];

                      return Obx(
                            () => GestureDetector(
                          onTap: () =>
                              controller.selectCategory(index),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 1.2.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(16),
                              gradient: category.isSelected.value
                                  ? AppColors.primaryGradient
                                  : null,
                              color: category.isSelected.value
                                  ? null
                                  : const Color(0xFF1C2140),
                            ),
                            child: AppText(
                              category.title,
                              color: Colors.white,
                              type: AppTextType.captionDark,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 3.h),

              /// Colors
              AppText(
                "Choose Color",
                color: Colors.white,
                type: AppTextType.body,
              ),

              SizedBox(height: 2.h),

              Obx(
                    () => Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    controller.colors.length,
                        (index) {
                      return GestureDetector(
                        onTap: () =>
                            controller.selectColor(index),
                        child: Obx(
                              () => Container(
                            height: 5.h,
                            width: 5.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.colors[index],
                              border: Border.all(
                                color:
                                controller.selectedColorIndex
                                    .value ==
                                    index
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: controller.colors[index]
                                      .withValues(alpha: .5),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),



              SizedBox(height: 5.h),

              AppButtonWidget(
                text: "Save Habit",
                height: 6.5.h,
                width: double.infinity,
                radius: 50,
                isGradient: true,
                onPressed: () => controller.saveHabit(),
              ),

              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }





}
