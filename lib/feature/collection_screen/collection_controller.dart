import 'package:daymark/core/model/habit_model.dart';
import 'package:daymark/core/storage_services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';

class CollectionController extends GetxController {
  final habits = <HabitModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHabits();
  }

  Future<void> loadHabits() async {
    final data = await StorageService.to.getHabits();
    habits.assignAll(data);
  }

  Future<void> deleteHabit(String id) async {
    await StorageService.to.deleteHabit(id);
    await loadHabits();
  }

  /// Group habits by relative day label
  Map<String, List<HabitModel>> get groupedHabits {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final Map<String, List<HabitModel>> grouped = {};

    for (final habit in habits) {
      final habitDate = DateTime(
        habit.createdAt.year,
        habit.createdAt.month,
        habit.createdAt.day,
      );
      final diff = today.difference(habitDate).inDays;

      String label;
      if (diff == 0) {
        label = "Today";
      } else if (diff == 1) {
        label = "Yesterday";
      } else {
        label = "$diff days ago";
      }

      grouped.putIfAbsent(label, () => []);
      grouped[label]!.add(habit);
    }

    return grouped;
  }

  Widget calendarDay(int index) {
    final highlightedDays = [
      8, 9, 11, 12, 15, 16, 18, 19, 21, 22, 23, 24,
    ];

    final selectedDay = 16;

    if (index < 2) {
      return const SizedBox();
    }

    final day = index - 1;

    return Center(
      child: Container(
        height: 4.h,
        width: 4.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: day == selectedDay
              ? AppColors.primaryGradient
              : null,
          color: highlightedDays.contains(day)
              ? AppColors.primary.withValues(alpha: .20)
              : Colors.transparent,
        ),
        child: Center(
          child: AppText(
            "$day",
            color: Colors.white,
            type: AppTextType.caption,
          ),
        ),
      ),
    );
  }
}