import 'package:asktoai_app/models/on_boarding_info_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreenController extends GetxController {
  var selectedPageIndex = 0.obs;

  bool get isLastPageValue =>
      selectedPageIndex.value == onboardingPages.length - 1;
  var pageControllerOnBoarding = PageController();

  forwardAction() {
    if (isLastPageValue) {
      //go to home page
    } else {
      pageControllerOnBoarding.nextPage(
          duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfoData> onboardingPages = [
    OnboardingInfoData('assets/images/robo2.png', 'Your AI assistant',
        'AskToAI is intended to boost your productivity by quick access to information.'),
    OnboardingInfoData('assets/images/robo1.png', 'Human-like conversations ',
        'AskToAI understand and response to your messages in a natural way.'),
    OnboardingInfoData('assets/images/robo3.png', 'I can do anything ',
        'I can write your essays, emails,coad,text and more.')
  ];
}
