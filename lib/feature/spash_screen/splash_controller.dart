import 'package:daymark/core/app_pages/app_routes.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashController  extends GetxController{

  @override
  void onInit() {
    print("splash c initialized");
     super.onInit();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    handleNavigation();
  }

  Future<void> handleNavigation() async {
    final prefsc = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 1),()   {
      var  isfirstLaunch = prefsc.getBool("isFistLaunch") ?? true;
      if(isfirstLaunch == true){
        Get.offNamed(AppRoutes.onboardingScreen);
      }
      Get.toNamed(AppRoutes.bottomNavScreen);
    });
  }
}
