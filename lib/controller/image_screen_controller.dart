import 'dart:developer';

import 'package:asktoai_app/ads/ad_integration.dart';
import 'package:asktoai_app/constants/string_res.dart';
import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/utils/api_services_data.dart';
import 'package:asktoai_app/utils/preference_services.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ImageScreenController extends GetxController {
  TextEditingController? imageTextController = TextEditingController();
  RxBool selections = false.obs;
  RxBool isSelected256 = true.obs;
  RxBool isSelected512 = false.obs;
  RxBool isSelected1024 = false.obs;
  RxBool isLoading = false.obs;
  RxString imageSize = '256x256'.obs;

  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  void onCheckboxChangedValue(String size) {
    if (size == '256*256') {
      imageSize.value = '256x256';
      isSelected512.value = false;
      isSelected1024.value = false;
    } else if (size == '512*512') {
      imageSize.value = '512x512';
      isSelected256.value = false;
      isSelected1024.value = false;
    } else if (size == '1024*1024') {
      imageSize.value = '1024x1024';
      isSelected256.value = false;
      isSelected512.value = false;
    }
  }

  RxList imageList = [].obs;

  searchPhoto() async {
    //print(Preferences.getInt(Preferences.imageCount.toString()));

    if (PreferenceServices.getInt(PreferenceServices.imageCount.toString()) <
            StringResource.imageCount ||
        StringResource.imageCount == 0) {
      FacebookInterstitialAd.showInterstitialAd();
      imageList.clear();
      isLoading.value = true;
      await ApiServicesData.imageGenerateResponse(
              imageTextController!.text, imageSize.value)
          .then((value) {
        log(value.toString());
        if (value.isNotEmpty) {
          imageList.addAll(value);
          PreferenceServices.setInt(
              PreferenceServices.imageCount.toString(),
              PreferenceServices.getInt(
                      PreferenceServices.imageCount.toString()) +
                  1);
          isLoading.value = false;
        } else {
          Get.snackbar(
            "Something went wrong",
            "No Image Generated...!",
            backgroundColor: CommonColors.red,
            snackPosition: SnackPosition.TOP,
            colorText: CommonColors.colorWhite,
            borderRadius: 10,
          );
        }
      });
    } else {
      Get.snackbar(
        'Alert!',
        "Your Demo Request Is Over",
        backgroundColor: CommonColors.red,
        snackPosition: SnackPosition.TOP,
        colorText: CommonColors.colorWhite,
        borderRadius: 10,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    FacebookAudienceNetwork.init(
      testingId: StringResource.facebookMainId,
      //"a77955ee-3304-4635-be65-81029b0f5201",
      iOSAdvertiserTrackingEnabled: true,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AudienceAd.loadInterstitialAd();
    });
  }
}
