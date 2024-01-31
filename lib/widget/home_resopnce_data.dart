import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeResponseData extends StatelessWidget {
  const HomeResponseData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (contentCtrl) {
      return SizedBox(
        width: MediaQuery.of(context).size.width > 350
            ? 350
            : MediaQuery.of(context).size.width > 200
                ? 180
                : 128,
        child: RawScrollbar(
            controller: contentCtrl.scrollController,
            trackColor: CommonColors.greyLight,
            thumbColor: CommonColors.backgroundAppbar,
            radius: const Radius.circular(4),
            thickness: 3,
            child: ListView(
                controller: contentCtrl.scrollController,
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CommonColors.bg1,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      '',
                      style: TextStyle(
                          color: CommonColors.colorWhite, fontSize: 14),
                    ),
                  ),
                ])),
      );
    });
  }
}
