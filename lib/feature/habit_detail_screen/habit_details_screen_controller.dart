 import 'package:daymark/core/model/habit_model.dart';
import 'package:daymark/core/storage_services/storage_service.dart';
import 'package:daymark/feature/home_screen/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_habit_screen/add_habit_controller.dart';

class HabitDetailsScreenController extends GetxController {
  final homeC = Get.find<HomeController>();
  final titleC = TextEditingController();
  RxString category = "".obs;
  final reminderEnabled = true.obs;
  late final HabitModel habit;
  RxInt selectedC = 0.obs;
  final storage = StorageService.to;

  /// Categories
  final categories = <HabitCategory>[
    HabitCategory(title: "Health", isSelected: true),
    HabitCategory(title: "Learning"),
    HabitCategory(title: "Productivity"),
    HabitCategory(title: "Lifestyle"),
    HabitCategory(title: "Mindset"),
    HabitCategory(title: "Other"),
  ].obs;


  @override
  void onInit() {
    super.onInit();
    habit = Get.arguments as HabitModel;
    reminderEnabled.value = habit.reminderEnabled;
    titleC.text = habit.title;
    category.value = habit.category;
  }

  Future updateHabit() async {
    if (titleC.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a habit name",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final updateHabit = HabitModel(
      id: habit.id,
      title: titleC.text.trim(),
      category: categories[selectedC.value].title,
      colorValue: habit.colorValue,
      reminderEnabled: habit.reminderEnabled,
      reminderTime: habit.reminderTime,
      completedCount: habit.completedCount,
      streak: habit.streak,
      createdAt: habit.createdAt,
      completedDates: habit.completedDates,
    );


    await StorageService.to.updateHabit(updateHabit);
   await  homeC.loadHabits();

    Get.back(result: true);
  }

  Future deleteHabit(String id) async {

    await StorageService.to.deleteHabit(id);
    await StorageService.to.getHabits();
    Get.back(result: true);
  }
}
