import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'utils/preference_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferenceServices.initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: CommonColors.background,
            appBarTheme: const AppBarTheme()),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        home: const SplashScreenWithImage());
  }
}
