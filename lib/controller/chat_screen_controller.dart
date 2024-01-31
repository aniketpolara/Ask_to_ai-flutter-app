import 'dart:developer';
import 'package:asktoai_app/ads/ad_integration.dart';
import 'package:asktoai_app/constants/string_res.dart';
import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/models/chat_model_service.dart';
import 'package:asktoai_app/utils/api_services_data.dart';
import 'package:asktoai_app/utils/preference_services.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  TextEditingController messageController = TextEditingController();
  RxList<ChatModelService> messages = RxList();
  final ScrollController scrollController = ScrollController();
  RxInt itemCount = 0.obs;

  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  setMessageList() async {
    if (PreferenceServices.getInt(PreferenceServices.chatTextCount.toString()) <
            StringResource.chatTextCount ||
        StringResource.chatTextCount == 0) {
      messages.add(ChatModelService(messageController.value.text, true));
      processChatView();
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

  processChatView() async {
    FacebookInterstitialAd.showInterstitialAd();
    //showInterstitialAd();
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    await ApiServicesData.chatCompeleteResponse(messageController.text)
        .then((value) {
      log("value Chat : $value");
      messages.add(
        ChatModelService(value, false),
      );
      PreferenceServices.setInt(
          PreferenceServices.chatTextCount.toString(),
          PreferenceServices.getInt(
                  PreferenceServices.chatTextCount.toString()) +
              1);
      messageController.clear();
    });
    Get.forceAppUpdate();
    await EasyLoading.dismiss();
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
