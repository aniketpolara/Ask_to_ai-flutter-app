import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/controller/on_boarding_screen_controller.dart';
import 'package:asktoai_app/screens/dashbord_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/preference_services.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingScreenController>(
        init: OnboardingScreenController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      controller: controller.pageControllerOnBoarding,
                      onPageChanged: controller.selectedPageIndex,
                      itemCount: controller.onboardingPages.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            index == 0
                                ? SizedBox(
                                    height: 70,
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            index == 0
                                ? Image.asset(
                                    controller.onboardingPages[index].imageAsset
                                        .toString(),
                                    height: 400,
                                  )
                                : const SizedBox(),
                            index != 0
                                ? SizedBox(
                                    height: 25,
                                  )
                                : SizedBox(),
                            Text(
                              controller.onboardingPages[index].title,
                              style: TextStyle(
                                  fontSize: index == 0 ? 40 : 32,
                                  fontWeight: FontWeight.w600,
                                  color: CommonColors.backgroundAppbar),
                            ),
                            index == 0
                                ? SizedBox(
                                    height: 10,
                                  )
                                : SizedBox(
                                    height: 10,
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Text(
                                controller.onboardingPages[index].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: index == 0 ? 20 : 20,
                                    color: CommonColors.titleTextColor),
                              ),
                            ),
                            index != 0
                                ? SizedBox(
                                    height: 20,
                                  )
                                : SizedBox(),
                            index != 0
                                ? Image.asset(
                                    controller
                                        .onboardingPages[index].imageAsset,
                                    height: 400,
                                  )
                                : const SizedBox(height: 32),
                          ],
                        );
                      }),
                ),
                SmoothPageIndicator(
                  controller: controller.pageControllerOnBoarding,
                  count: controller.onboardingPages.length,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                      activeDotColor: CommonColors.backgroundAppbar,
                      dotColor: CommonColors.colorWhite,
                      dotHeight: 8,
                      dotWidth: 8),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 19, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      controller.isLastPageValue
                          ? const SizedBox(width: 10)
                          : InkWell(
                              onTap: () {
                                controller.pageControllerOnBoarding
                                    .jumpToPage(2);
                              },
                              child: const Text('Skip',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: CommonColors.titleTextColor))),
                      InkWell(
                        onTap: () {
                          if (controller.isLastPageValue) {
                            PreferenceServices.setBool(
                                PreferenceServices.isFirstTime, true);

                            Get.offAll(() => DashBoardScreenLayout());
                          } else {
                            controller.forwardAction();
                          }
                        },
                        child: Row(
                          children: [
                            Obx(() {
                              return Text(
                                controller.isLastPageValue ? 'Start' : 'Next',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: CommonColors.titleTextColor),
                              );
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
