import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreenWithImage extends StatelessWidget {
  const SplashScreenWithImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashWithImageScreenController>(
        init: SplashWithImageScreenController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: CommonColors.backgroundAppbar,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      "assets/images/logo.png",
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
