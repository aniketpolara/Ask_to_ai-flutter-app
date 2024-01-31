import 'dart:developer';
import 'package:asktoai_app/constants/string_res.dart';
import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/controller/home_screen_controller.dart';
import 'package:asktoai_app/widget/common_widgets.dart';
import 'package:asktoai_app/widget/common_textform_fileds.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreenLayout extends StatelessWidget {
  const HomeScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: CommonColors.background,
              body: SingleChildScrollView(
                child: Column(
                  children: [
// public String BANNER_PLACEMENT_ID = "549167759165615_549192715829786";
// public String INT_PLACEMENT_ID = "549167759165615_549190905829967";
// public String RV_PLACEMENT_ID = "549167759165615_549192132496511";
// public String NATIVE_PLACEMENT_ID = "549167759165615_551513495597708";
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
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          CommonWidget().textCommon("Business Idea"),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: CommonColors.textField,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: DropdownButtonFormField(
                                  dropdownColor: CommonColors.textField,
                                  value: controller.selectedValue,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    border: CommonWidget().commonBorder(),
                                    disabledBorder:
                                        CommonWidget().commonBorder(),
                                    focusedBorder:
                                        CommonWidget().commonBorder(),
                                    enabledBorder:
                                        CommonWidget().commonBorder(),
                                    errorBorder: CommonWidget().commonBorder(),
                                    filled: true,
                                    hintStyle: const TextStyle(fontSize: 14),
                                    hintText: "Name",
                                    fillColor: CommonColors.textField,
                                  ),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  isDense: true,
                                  isExpanded: true,
                                  hint: const Text(
                                    'Business Idea',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  items: controller.contentOptionList
                                      .asMap()
                                      .entries
                                      .map((e) => DropdownMenuItem(
                                          value: e.value,
                                          child: Text(
                                            e.value.toString(),
                                            style: const TextStyle(
                                              color: CommonColors.black,
                                            ),
                                          )))
                                      .toList(),
                                  onChanged: (val) {})),
                          const SizedBox(height: 15),
                          CommonWidget().textCommon("Topic"),
                          const SizedBox(height: 8),
                          Container(
                            decoration: const BoxDecoration(
                              color: CommonColors.colorWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: CommonTextFormFiled(
                                textColor: CommonColors.black,
                                controller: controller.contentController.value,
                                hintText: 'Enter Prompt ',
                                fillColor: CommonColors.textField),
                          ),
                          InkWell(
                            onTap: () async {
                              FacebookInterstitialAd.showInterstitialAd();
                              if (controller
                                  .contentController.value.text.isNotEmpty) {
                                //controller.showInterstitialAd();
                                //await AdManager.showIntAd();
                                FocusManager.instance.primaryFocus?.unfocus();
                                await controller.addData();
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
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(vertical: 25),
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: CommonColors.backgroundAppbar,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: controller.isLoading.value == true
                                    ? const SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                    : const Text(
                                        "Generate Content",
                                        style: TextStyle(
                                          color: CommonColors.colorWhite,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          controller.data.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    left: 20,
                                    right: 20,
                                  ),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color: Colors.grey.shade300,
                                            offset: Offset(3, 3))
                                      ],
                                      color: CommonColors.textField,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Description",
                                                style: TextStyle(
                                                    color: CommonColors
                                                        .backgroundAppbar,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Row(children: [
                                              InkWell(
                                                onTap: () {
                                                  Share.share(controller
                                                      .data.value
                                                      .toString());
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: CommonColors
                                                          .backgroundDescription,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: SvgPicture.asset(
                                                      // ignore: deprecated_member_use
                                                      color: HexColor("000000"),
                                                      'assets/icons/share.svg'),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.contentController
                                                      .value.text = '';
                                                  controller.data.value = "";
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: CommonColors
                                                          .backgroundDescription,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: SvgPicture.asset(
                                                      // ignore: deprecated_member_use
                                                      color: HexColor("000000"),
                                                      'assets/icons/trash.svg'),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.snackbar(
                                                    "Copy",
                                                    "Copy to Clipboard Successfully ",
                                                    snackPosition:
                                                        SnackPosition.TOP,
                                                    colorText:
                                                        CommonColors.black,
                                                    backgroundColor:
                                                        CommonColors.colorWhite,
                                                    borderRadius: 10,
                                                  );
                                                  Clipboard.setData(
                                                    ClipboardData(
                                                      text: controller
                                                          .data.value
                                                          .toString(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: CommonColors
                                                        .backgroundDescription,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: SvgPicture.asset(
                                                    // ignore: deprecated_member_use
                                                    color: HexColor("000000"),
                                                    'assets/icons/copy.svg',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                            ])
                                          ]),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        margin: EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                          color: CommonColors
                                              .backgroundDescription,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          controller.data.value,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: HexColor("000000"),
                                              height: 1.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      ).marginSymmetric(horizontal: 25),
                    ),
                  ],
                ),
              ));
        });
  }
}
