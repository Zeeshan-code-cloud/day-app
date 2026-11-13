import 'package:daymark/feature/collection_screen/collection_controller.dart';
import 'package:daymark/feature/collection_screen/collection_screen.dart';
import 'package:daymark/feature/home_screen/home_controller.dart';
import 'package:daymark/feature/home_screen/home_screen.dart';
import 'package:daymark/feature/setting_screen/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt currentIndex = 0.obs;
  List<Widget> pages = [
    HomeScreen(),
    CollectionScreen(),
    SettingScreen(),
  ];

  void setIndex(int value) {
    currentIndex.value = value;

    // Reload habits when switching to Home or Collection tab
    if (value == 0) {
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().loadHabits();
      }
    } else if (value == 1) {
      if (Get.isRegistered<CollectionController>()) {
        Get.find<CollectionController>().loadHabits();
      }
    }

    update();
  }
}