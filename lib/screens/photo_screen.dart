import 'dart:developer';

import 'package:asktoai_app/constants/string_res.dart';
import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/controller/image_screen_controller.dart';
import 'package:asktoai_app/screens/image_details_screen.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PhotoLayoutScreen extends StatelessWidget {
  const PhotoLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ImageScreenController>(
        init: ImageScreenController(),
        builder: (controller) {
          return Scaffold(
            body: Column(
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.isSelected256.value = true;
                          controller.onCheckboxChangedValue('256*256');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.31,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15)),
                              color: controller.isSelected256.value
                                  ? CommonColors.backgroundAppbar
                                  : CommonColors.textField),
                          child: Center(
                            child: Text(
                              "256 * 256",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: controller.isSelected256.value
                                      ? CommonColors.colorWhite
                                      : CommonColors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.isSelected512.value = true;
                          controller.onCheckboxChangedValue('512*512');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.31,
                          decoration: BoxDecoration(
                              color: controller.isSelected512.value
                                  ? CommonColors.backgroundAppbar
                                  : CommonColors.textField),
                          child: Center(
                            child: Text(
                              "512 * 512",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: controller.isSelected512.value
                                      ? CommonColors.colorWhite
                                      : CommonColors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.isSelected1024.value = true;
                          controller.onCheckboxChangedValue('1024*1024');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.31,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              color: controller.isSelected1024.value
                                  ? CommonColors.backgroundAppbar
                                  : CommonColors.textField),
                          child: Center(
                            child: Text(
                              "1024 * 1024",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: controller.isSelected1024.value
                                      ? CommonColors.colorWhite
                                      : CommonColors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: controller.imageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  Get.to(const ImageDetailScreen(),
                                      arguments: controller.imageList[index]);
                                  log(controller.imageList[index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: CommonColors.textField,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                        controller.imageList[index],
                                      ))),
                                ));
                          },
                        ).paddingSymmetric(horizontal: 10),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
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
                        controller: controller.imageTextController,
                        style: const TextStyle(color: CommonColors.black),
                        decoration: const InputDecoration(
                          hintText: "Enter your Message....",
                          hintStyle: TextStyle(color: CommonColors.black),
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
                        onTap: () {
                          if (controller.imageTextController!.text.isNotEmpty) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.searchPhoto();
                            controller.imageTextController!.text = "";
                          } else {
                            Get.snackbar(
                              'Write Something',
                              '',
                              backgroundColor: CommonColors.red,
                              snackPosition: SnackPosition.TOP,
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
