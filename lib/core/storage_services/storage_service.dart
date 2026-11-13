import 'package:daymark/core/model/habit_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final habitKey = "habitKey";
  final SharedPreferences prefs;

  static StorageService get to => Get.find<StorageService>();

  StorageService({required this.prefs});

  Future<List<HabitModel>> getHabits() async {
    final data = prefs.getStringList(habitKey) ?? [];
    return data.map((e) => HabitModel.fromJson(e)).toList();
  }

  Future addHabit(HabitModel habitModel) async {
    final habit = await getHabits();
    habit.add(habitModel);

    await prefs.setStringList(habitKey, habit.map((e) => e.toJson()).toList());
  }

  Future updateHabit(HabitModel updatedHabit) async {

    final habits = await getHabits();

   final index =  habits.indexWhere((e) => e.id == updatedHabit.id);
   if(index != -1){
     habits[index] = updatedHabit;
   }

   await prefs.setStringList(habitKey, habits.map((e) => e.toJson()).toList());
  }

  Future deleteHabit(String id) async {
    final habit = await  getHabits();
    habit.removeWhere((e) {
     return  e.id == id;
    });
    
    await prefs.setStringList(habitKey, habit.map((e) => e.toJson()).toList());
  }

  Future clearAll() async {
    await prefs.remove(habitKey);
  }
}
