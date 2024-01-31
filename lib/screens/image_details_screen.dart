import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/controller/image_details_screen_contoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageDetialsScreenContoller>(
        init: ImageDetialsScreenContoller(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: CommonColors.backgroundAppbar,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        Share.share(controller.imageUrl.value,
                            subject: "Ask To Ai image");
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/share.svg',
                        color: CommonColors.colorWhite,
                      )),
                  IconButton(
                      onPressed: () {
                        controller.downloadPhotos();
                      },
                      icon: const Icon(
                        Icons.download,
                        color: CommonColors.colorWhite,
                      ))
                ],
              ),
              body: Image.network(
                controller.imageUrl.value,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ));
        });
  }
}
