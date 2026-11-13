import 'package:daymark/feature/add_habit_screen/add_habit_controller.dart';
import 'package:daymark/feature/bottom_nav_screen/bottom_nav_controller.dart';
import 'package:daymark/feature/collection_screen/collection_controller.dart';
import 'package:daymark/feature/habit_detail_screen/habit_details_screen_controller.dart';
import 'package:daymark/feature/home_screen/home_controller.dart';
import 'package:daymark/feature/onboarding_screen/onboarding_controller.dart';
import 'package:daymark/feature/setting_screen/setting_controller.dart';
import 'package:daymark/feature/spash_screen/splash_controller.dart';
import 'package:get/get.dart';

class AppBinding  extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => OnboardingController(), fenix: true);
    Get.lazyPut(() => BottomNavController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SettingController(), fenix: true);
    Get.lazyPut(() => CollectionController(), fenix: true);
    Get.lazyPut(() => HabitDetailsScreenController(), fenix: true);
    Get.lazyPut(() =>
        AddHabitController(), fenix: true);
  }

}
class SplashBinding extends AppBinding{
  @override
  void dependencies() {
    // TODO: implement dependencies
    super.dependencies();
    Get.put(SplashController(), );
  }
}