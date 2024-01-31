import 'dart:developer';
import 'package:asktoai_app/constants/string_res.dart';
import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/controller/chat_screen_controller.dart';
import 'package:asktoai_app/widget/chat_message_view_layout.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatScreenLayout extends StatelessWidget {
  const ChatScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ChatScreenController>(
        init: ChatScreenController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      child: controller.currentAd = FacebookBannerAd(
                    // placementId: "YOUR_PLACEMENT_ID",
                    placementId: StringResource.bannerAndroidAdmobAdId,
                    // "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
                    bannerSize: BannerSize.STANDARD,
                    listener: (result, value) {
                      print("Banner Ad: $result -->  $value");
                    },
                  )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          controller.messages.isEmpty
                              ? const SizedBox()
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.messages.length,
                                  controller: controller.scrollController,
                                  itemBuilder: (context, int index) {
                                    return ChatMessageViewLayout(
                                      text: controller.messages[index].msg,
                                      isCurrentUser:
                                          controller.messages[index].isPerson,
                                    );
                                  },
                                ),
                        ],
                      )),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: CommonColors.textField,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        minLines: 1,
                        controller: controller.messageController,
                        style: const TextStyle(color: CommonColors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: CommonColors.textField,
                          hintText: "Enter your Message....",
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Your Message';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () async {
                          if (controller.messageController.text.isNotEmpty) {
                            controller.setMessageList();
                            FocusManager.instance.primaryFocus?.unfocus();
                          } else {
                            Get.snackbar(
                              'Write Something',
                              '',
                              backgroundColor: CommonColors.red,
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: CommonColors.colorWhite,
                              borderRadius: 10,
                            );
                            log("write something");
                          }
                        },
                        child: Container(
                            height: 42,
                            width: 42,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: CommonColors.backgroundAppbar,
                                borderRadius: BorderRadius.circular(50)),
                            child:
                                SvgPicture.asset('assets/icons/send_icon.svg')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
