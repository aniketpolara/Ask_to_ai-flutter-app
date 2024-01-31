import 'package:asktoai_app/ads/ad_integration.dart';
import 'package:asktoai_app/constants/string_res.dart';
import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/utils/api_services_data.dart';
import 'package:asktoai_app/utils/preference_services.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  Rx<TextEditingController> contentController = TextEditingController().obs;
  RxBool isLoading = false.obs;
  String? selectedValue = "Business Idea";
  RxList contentOptionList = [].obs;
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 50.0);
  RxString data = "".obs;

  @override
  void onInit() {
    addContentOption();
    super.onInit();
    FacebookAudienceNetwork.init(
      testingId: StringResource.facebookMainId,
      //"3b656c58-53ab-43a8-a0d6-d1f82abdf251",
      iOSAdvertiserTrackingEnabled: true,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AudienceAd.loadInterstitialAd();
    });
  }

  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  addContentOption() {
    contentOptionList.addAll([
      "Business Idea",
      "Cover Letter",
      "Blog Section",
      "Marketing Writing",
      "Service"
    ]);
  }

  addData() async {
    if (PreferenceServices.getInt(
                PreferenceServices.textCompletionCount.toString()) <
            StringResource.textCompletionCount ||
        StringResource.textCompletionCount == 0) {
      isLoading.value = true;
      await ApiServicesData.chatCompeleteResponse(contentController.value.text)
          .then((value) {
        isLoading.value = false;
        data.value = value;
        PreferenceServices.setInt(
            PreferenceServices.textCompletionCount.toString(),
            PreferenceServices.getInt(
                    PreferenceServices.textCompletionCount.toString()) +
                1);
        update();
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
}
