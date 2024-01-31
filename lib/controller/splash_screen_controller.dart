import 'dart:async';
import 'package:asktoai_app/constants/string_res.dart';
import 'package:asktoai_app/screens/dashbord_screen.dart';

import 'package:asktoai_app/screens/on_boarding_screen.dart';
import 'package:asktoai_app/utils/preference_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class SplashWithImageScreenController extends GetxController {
  @override
  void onInit() {
    adsWithFirebase();
    onGoNextPage();
    if (PreferenceServices.getInt(
                PreferenceServices.textCompletionCount.toString()) ==
            0 &&
        PreferenceServices.getInt(PreferenceServices.imageCount.toString()) ==
            0 &&
        PreferenceServices.getInt(
                PreferenceServices.chatTextCount.toString()) ==
            0) {
      PreferenceServices.setInt(
          PreferenceServices.textCompletionCount.toString(), 1);
      PreferenceServices.setInt(PreferenceServices.imageCount.toString(), 1);
      PreferenceServices.setInt(PreferenceServices.chatTextCount.toString(), 1);
    }

    super.onInit();
  }

  Future<void> adsWithFirebase() async {
    await FirebaseDatabase.instance.ref('banner_ads').once().then((value) {
      String addData = value.snapshot.value as String;
      StringResource.bannerAndroidAdmobAdId = addData;
    });
    // print(Constant.bannerAndroidAdmobAdId);

    await FirebaseDatabase.instance
        .ref('interstitial_ads')
        .once()
        .then((value) {
      String addData = value.snapshot.value as String;
      StringResource.interstitialAndroidAdmobAdId = addData;
    });
    //print(Constant.interstitialAndroidAdmobAdId);

    await FirebaseDatabase.instance
        .ref('facebook_main_id')
        .once()
        .then((value) {
      String addData = value.snapshot.value as String;
      StringResource.facebookMainId = addData;
    });
    // print(Constant.facebookMainId);

    await FirebaseDatabase.instance.ref('api_key').once().then((value) {
      String addData = value.snapshot.value as String;
      StringResource.txtAPIKEY = addData;
    });
    //print(Constant.txtAPIKEY);
  }

  onGoNextPage() {
    Timer(const Duration(seconds: 5), () {
      if (!PreferenceServices.getBool(PreferenceServices.isFirstTime)) {
        Get.offAll(() => const OnBoardingPage());
      } else {
        Get.offAll(() => DashBoardScreenLayout());
      }
    });
  }
}
