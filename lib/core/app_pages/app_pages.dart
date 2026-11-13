import 'package:daymark/core/binding/app_binding.dart';
import 'package:daymark/feature/add_habit_screen/add_habit_screen.dart';
import 'package:daymark/feature/habit_detail_screen/habit_details_screen.dart';
import 'package:get/get.dart';

import '../../feature/bottom_nav_screen/bottom_nav_screen.dart';
import '../../feature/collection_screen/collection_screen.dart';
import '../../feature/home_screen/home_screen.dart';
import '../../feature/onboarding_screen/onboarding_screen.dart';
import '../../feature/setting_screen/setting_screen.dart';
import '../../feature/spash_screen/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splashScreen, page: () => const SplashView(), binding: SplashBinding()),
    GetPage(name: AppRoutes.onboardingScreen, page: () => const OnboardingScreen(), binding: AppBinding()),
    GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen(), binding: AppBinding()),
    GetPage(name: AppRoutes.bottomNavScreen, page: () => const BottomNavScreen(), binding: AppBinding()),
    GetPage(name: AppRoutes.collectionScreen, page: () => const CollectionScreen(), binding: AppBinding()),
    GetPage(name: AppRoutes.settingScreen, page: () => const SettingScreen(), binding: AppBinding()),
    GetPage(name: AppRoutes.addHabitScreen, page: () => const AddHabitScreen(), binding: AppBinding()),
    GetPage(name: AppRoutes.habitDetailScren, page: () => const HabitDetailsScreen(), binding: AppBinding()),
  ];
}