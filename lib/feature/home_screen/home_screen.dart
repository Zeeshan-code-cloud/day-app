import 'package:daymark/core/app_pages/app_routes.dart';
import 'package:daymark/core/model/habit_model.dart';
import 'package:daymark/feature/home_screen/home_controller.dart';
import 'package:daymark/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/app_text.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1226),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(height: 2.h),

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                  () =>  AppText(
                          controller.welcomMessage.value,
                          type: AppTextType.heading1,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: .5.h),
                      Row(
                        children: [
                          AppText(
                            "Let's make today count.",
                            color: AppColors.darkTextSecondary,
                            type: AppTextType.captionDark,
                          ),
                          SizedBox(width: 2.w),
                          Container(
                            height: 2.h,
                            width: 2.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.amber,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              /// Streak Card
              Obx(() {
                final totalHabits = controller.habits.length;
                final completedCount = controller.habits
                    .where((h) => h.completedDates.contains(
                        DateTime.now().toString().split(' ')[0]))
                    .length;
                final progress =
                    totalHabits > 0 ? completedCount / totalHabits : 0.0;

                return Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: const Color(0xFF1B1E37),
                    border: Border.all(
                      color: Colors.white.withOpacity(.05),
                    ),
                  ),
                  child: Row(
                    children: [
                      /// Streak
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "🔥",
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                AppText(
                                  "$totalHabits",
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            AppText(
                              "Total Habits",
                              color: Colors.white70,
                            ),
                            SizedBox(height: 1.h),
                            AppText(
                              "Keep going! You're doing great.",
                              color: AppColors.darkTextSecondary,
                              type: AppTextType.micro,
                            ),
                          ],
                        ),
                      ),

                      /// Progress
                      SizedBox(
                        height: 14.h,
                        width: 14.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 14.h,
                              width: 14.h,
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 8,
                                backgroundColor: Colors.white12,
                                valueColor: const AlwaysStoppedAnimation(
                                  Color(0xFF6C63FF),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  "$completedCount/$totalHabits",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                                AppText(
                                  "Today",
                                  color: Colors.white70,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),

              SizedBox(height: 3.h),

              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  "Today's Habits",
                  type: AppTextType.heading3,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 2.h),

              /// Habit List
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF15192F),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Obx(() {
                    if (controller.habits.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/empty_states_icon.svg',
                              height: 12.h,
                              width: 12.h,
                            ),
                            SizedBox(height: 2.h),
                            AppText(
                              "No habits yet",
                              color: Colors.white,
                              type: AppTextType.heading3,
                            ),
                            SizedBox(height: 1.h),
                            AppText(
                              "Tap + to create your first habit",
                              color: AppColors.darkTextSecondary,
                              type: AppTextType.captionDark,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: controller.habits.length,
                      itemBuilder: (context, index) {
                        final habit = controller.habits[index];
                        return _habitTile(
                          context: context,
                          habit: habit,
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          final result = await Get.toNamed(AppRoutes.addHabitScreen);
          if (result == true) {
            controller.loadHabits();
          }
        },
        child: Container(
          height: 8.h,
          width: 8.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _habitTile({
    required BuildContext context,
    required HabitModel habit,
  }) {
    final color = Color(habit.colorValue);
    final todayStr = DateTime.now().toString().split(' ')[0];
    final completed = habit.completedDates.contains(todayStr);

    return Dismissible(
      key: Key(habit.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1A1E35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: AppText(
              "Delete Habit",
              color: Colors.white,
              type: AppTextType.heading3,
            ),
            content: AppText(
              "Are you sure you want to delete \"${habit.title}\"?",
              color: AppColors.darkTextSecondary,
              type: AppTextType.body,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: AppText(
                  "Cancel",
                  color: Colors.white70,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: AppText(
                  "Delete",
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        controller.deleteHabit(habit.id);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.delete_outline,
          color: Colors.red,
          size: 22.sp,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 1.5.h,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(.05),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  await Get.toNamed(
                    AppRoutes.habitDetailScren,
                    arguments: habit,
                  );
                  controller.loadHabits();
                },
                child: Row(
                  children: [
                    /// Icon
                    Container(
                      height: 5.5.h,
                      width: 5.5.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withOpacity(.15),
                      ),
                      child: Center(
                        child: Text(
                          _getCategoryEmoji(habit.category),
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 3.w),

                    /// Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            habit.title,
                            color: Colors.white,
                            type: AppTextType.body,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: .5.h),
                          AppText(
                            habit.category,
                            color: AppColors.darkTextSecondary,
                            type: AppTextType.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Status
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                controller.toggleHabitCompletion(habit);
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 250,
                ),
                height: 3.8.h,
                width: 3.8.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient:
                      completed ? AppColors.primaryGradient : null,
                  border: Border.all(
                    color: completed
                        ? Colors.transparent
                        : AppColors.darkTextSecondary
                            .withOpacity(.5),
                    width: 2,
                  ),
                ),
                child: completed
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18.sp,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
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
}
