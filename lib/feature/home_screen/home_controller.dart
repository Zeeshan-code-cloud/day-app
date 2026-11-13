import 'package:daymark/core/model/habit_model.dart';
import 'package:daymark/core/storage_services/storage_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final habits = <HabitModel>[].obs;
  RxString welcomMessage = "Good Morning".obs;

  @override
  void onInit() {
    super.onInit();
    updateGreetings();
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

  Future<void> toggleHabitCompletion(HabitModel habit) async {
    final todayStr = DateTime.now().toString().split(' ')[0];
    final List<String> updatedDates = List<String>.from(habit.completedDates);

    if (updatedDates.contains(todayStr)) {
      updatedDates.remove(todayStr);
    } else {
      updatedDates.add(todayStr);
    }

    final newStreak = calculateStreak(updatedDates);
    final updatedHabit = habit.copyWith(
      completedDates: updatedDates,
      completedCount: updatedDates.length,
      streak: newStreak,
    );

    await StorageService.to.updateHabit(updatedHabit);
    await loadHabits();
  }

  int calculateStreak(List<String> completedDates) {
    if (completedDates.isEmpty) return 0;
    final set = completedDates.toSet();
    int streak = 0;
    DateTime date = DateTime.now();
    String dateStr = date.toString().split(' ')[0];

    if (!set.contains(dateStr)) {
      date = date.subtract(const Duration(days: 1));
      dateStr = date.toString().split(' ')[0];
    }

    while (set.contains(dateStr)) {
      streak++;
      date = date.subtract(const Duration(days: 1));
      dateStr = date.toString().split(' ')[0];
    }

    return streak;
  }

  void updateGreetings() {
    final hours = DateTime.now().hour;
    if (hours >= 0 && hours < 12) {
      welcomMessage.value = "Good Morning";
    } else if (hours >= 12 && hours < 17) {
      welcomMessage.value = "Good Afternoon";
    } else if (hours < 21) {
      welcomMessage.value = "Good Evening";
    } else {
      welcomMessage.value = "Good Night";
    }
  }
}