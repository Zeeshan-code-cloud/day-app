import 'package:daymark/core/app_pages/app_pages.dart';
import 'package:daymark/core/app_pages/app_routes.dart';
import 'package:daymark/core/storage_services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs: prefs);
  }, permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, _, _) {
        return GetMaterialApp(
          title: 'Day Mark',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          getPages: AppPages.routes,
          initialRoute: AppRoutes.splashScreen,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
        );
      },
    );
  }
}
