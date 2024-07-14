import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager/controller_binder.dart';
import 'package:task_manager/ui/screens/auth%20screen/splash_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      home: const SplashScreen(),
      theme: lightThemeData(),
      initialBinding: ControllerBinder(),
    );
  }

  ThemeData lightThemeData() {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            letterSpacing: 0.4,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            fixedSize: const Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ));
  }
}
