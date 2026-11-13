import 'package:daymark/core/model/habit_model.dart';
import 'package:daymark/core/storage_services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddHabitController extends GetxController {
  final habitController = TextEditingController();

  /// Categories
  final categories = <HabitCategory>[
    HabitCategory(title: "Health", isSelected: true),
    HabitCategory(title: "Learning"),
    HabitCategory(title: "Productivity"),
    HabitCategory(title: "Lifestyle"),
    HabitCategory(title: "Mindset"),
    HabitCategory(title: "Other"),
  ].obs;

  final selectedColorIndex = 0.obs;

  /// Colors
  final colors = <Color>[
    const Color(0xFF8B5CF6),
    const Color(0xFF7EA7FF),
    const Color(0xFF7AD66F),
    const Color(0xFFF5B942),
    const Color(0xFFFF7D6B),
    const Color(0xFFD946EF),
  ].obs;

  void selectCategory(int index) {
    for (var category in categories) {
      category.isSelected.value = false;
    }
    categories[index].isSelected.value = true;
  }

  void selectColor(int index) {
    selectedColorIndex.value = index;
  }

  String get selectedCategory =>
      categories.firstWhere((e) => e.isSelected.value).title;

  Color get selectedColor => colors[selectedColorIndex.value];

  Future<void> saveHabit() async {
    final title = habitController.text.trim();
    if (title.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a habit name",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final habit = HabitModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      category: selectedCategory,
      colorValue: selectedColor.value,
      reminderEnabled: false,
      reminderTime: "09:00 AM",
      completedCount: 0,
      streak: 0,
      createdAt: DateTime.now(),
      completedDates: [],
    );

    await StorageService.to.addHabit(habit);
    habitController.clear();
    Get.back(result: true);
  }
}

class HabitCategory {
  final String title;
  final RxBool isSelected;

  HabitCategory({
    required this.title,
    bool isSelected = false,
  }) : isSelected = isSelected.obs;
}
