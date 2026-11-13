import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController{



  Future<void> launchToWeb(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("launch error", "url are invalid");
    }
  }

    Future<void> launchPlayStore(String packageName) async {
    final Uri uri = Uri.parse(
      "https://play.google.com/store/apps/details?id=$packageName",
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        "Error",
        "Could not open Play Store",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


}