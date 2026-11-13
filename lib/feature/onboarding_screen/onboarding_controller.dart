
import 'package:daymark/core/app_pages/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController  extends GetxController{

  RxInt currentIndex = 0.obs;
  final pageC = PageController();


  List<String> headings = [
    "Track Daily Habits",
    "Build Strong Streak",
    "Become Your Best Self",
  ];

  List<String> captions = [
    "Create simple habits, set your gaols, and make progress every daily",
    "Stay consistent and watch your progress in real time",
    "Small steps today a bitter tomorrow",
  ];

  List<String> images = [
    "assets/image/img_2.png",
    "assets/image/img_1.png",
    "assets/image/img.png",
  ];


  void setIndex (int index) {
    currentIndex.value = index;
    update();
  }
  void getStarted()  async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFistLaunch", false);
    Get.offNamed(AppRoutes.bottomNavScreen);
  }
}