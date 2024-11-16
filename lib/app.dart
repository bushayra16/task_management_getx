import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/Screens/add_new_task_screen.dart';
import 'package:task_management/ui/Screens/canceled_screen.dart';
import 'package:task_management/ui/Screens/completed_screen.dart';
import 'package:task_management/ui/Screens/forgot_password_email.dart';
import 'package:task_management/ui/Screens/forgot_password_otp_screen.dart';
import 'package:task_management/ui/Screens/new_task_screen.dart';
import 'package:task_management/ui/Screens/password_set_screen.dart';
import 'package:task_management/ui/Screens/progress_screen.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/Screens/sign_up_screen.dart';
import 'package:task_management/ui/Screens/splash_screen.dart.dart';
import 'package:task_management/ui/Screens/main_bottom_nav_bar.dart';
import 'package:task_management/ui/controller_binder.dart';
import 'package:task_management/ui/utils/app_colors.dart';

class TaskManagementApp extends StatefulWidget {
  const TaskManagementApp({super.key});
 static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagementApp> createState() => _TaskManagementAppState();
}

class _TaskManagementAppState extends State<TaskManagementApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagementApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const SplashScreen(),
        BottomNavBar.name : (context) => const BottomNavBar(),
        SignInScreen.name : (context) => const SignInScreen(),
        SignUpScreen.name : (context) => const SignUpScreen(),
        ProgressTaskScreen.name : (context) => const ProgressTaskScreen(),
        NewTaskScreen.name : (context) => const NewTaskScreen(),
        CompletedTaskScreen.name : (context) => const CompletedTaskScreen(),
        CancelTaskScreen.name : (context) => const CancelTaskScreen(),
        AddNewTaskScreen.name : (context) => const AddNewTaskScreen(),
        VerificationScreen.name : (context) => const VerificationScreen(),

      },
      initialBinding: ControllerBinder(),
    );
  }
}

ElevatedButtonThemeData _elevatedButtonTheme () {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        )
    ),
  );
}

InputDecorationTheme _inputDecorationTheme () {
  return InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w300
      ),
      border:  _inputBorder(),
      enabledBorder: _inputBorder(),
      errorBorder:  _inputBorder(),
      focusedBorder:  _inputBorder()
  );
}
OutlineInputBorder _inputBorder () {
return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(8)
);
}



