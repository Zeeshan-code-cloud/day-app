import 'package:daymark/core/app_pages/app_routes.dart';
import 'package:daymark/core/model/habit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import 'collection_controller.dart';

class CollectionScreen extends GetView<CollectionController> {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1226),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              AppText(
                "History",
                type: AppTextType.heading1,
                color: Colors.white,
              ),


              SizedBox(height: 3.h),

              /// Habits grouped by day
              Expanded(
                child: Obx(() {
                  if (controller.habits.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
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
                            "Your habit history will appear here",
                            color: AppColors.darkTextSecondary,
                            type: AppTextType.captionDark,
                          ),
                        ],
                      ),
                    );
                  }

                  final grouped = controller.groupedHabits;
                  final sortedKeys = grouped.keys.toList();

                  // Sort: Today first, Yesterday second, then by number ascending
                  sortedKeys.sort((a, b) {
                    int getOrder(String key) {
                      if (key == "Today") return 0;
                      if (key == "Yesterday") return 1;
                      final match = RegExp(r'(\d+)').firstMatch(key);
                      if (match != null) {
                        return int.parse(match.group(1)!);
                      }
                      return 999;
                    }

                    return getOrder(a).compareTo(getOrder(b));
                  });

                  return ListView.builder(
                    itemCount: sortedKeys.length,
                    itemBuilder: (context, sectionIndex) {
                      final label = sortedKeys[sectionIndex];
                      final sectionHabits = grouped[label]!;

                      return Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 1.h,
                              top: sectionIndex > 0
                                  ? 2.h
                                  : 0,
                            ),
                            child: AppText(
                              label,
                              color: Colors.white,
                              type: AppTextType.heading3,
                            ),
                          ),
                          ...sectionHabits.map(
                            (habit) => _habitTile(
                              context: context,
                              habit: habit,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ),
            ],
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
                onPressed: () =>
                    Navigator.of(context).pop(false),
                child: AppText(
                  "Cancel",
                  color: Colors.white70,
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true),
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
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoutes.habitDetailScren,
            arguments: habit,
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 0.5.h),
          padding: EdgeInsets.symmetric(
            vertical: 1.5.h,
            horizontal: 3.w,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF15192F),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(.05),
            ),
          ),
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
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

  Widget _weekText(String day) {
    return AppText(
      day,
      color: AppColors.darkTextSecondary,
      type: AppTextType.micro,
    );
  }
}
