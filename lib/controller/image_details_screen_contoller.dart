import 'dart:developer';
import 'dart:io';
import 'package:asktoai_app/constants/common_colors.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageDetialsScreenContoller extends GetxController {
  final RxString imageUrl = ''.obs;
  dynamic photos;
  // Permission? permissions;
  // PermissionStatus permissionStatus = PermissionStatus.denied;

  downloadPhotos() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> status;

    if (Platform.isAndroid) {
      if (androidInfo.version.sdkInt <= 32) {
        status = await [Permission.storage].request();
      } else {
        status = await [Permission.photos].request();
      }
    } else {
      status = await [Permission.photosAddOnly].request();
    }

    var allAccept = true;
    status.forEach((permission, status) {
      if (status != PermissionStatus.granted) {
        allAccept = false;
      }
    });

    if (allAccept) {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      update();
      var response = await Dio().get(imageUrl.value,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "probot");
      await EasyLoading.dismiss();
      Get.snackbar(
        'Success',
        "Image Downloaded Successfully",
        snackPosition: SnackPosition.TOP,
        colorText: CommonColors.black,
        backgroundColor: CommonColors.colorWhite,
        borderRadius: 10,
      );
      log(result);
      update();
    } else {
      await EasyLoading.dismiss();
      Get.snackbar(
        'Alert!',
        "Something Went Wrong",
        backgroundColor: CommonColors.red,
        snackPosition: SnackPosition.TOP,
        colorText: CommonColors.colorWhite,
        borderRadius: 10,
      );
      update();
    }
  }

  @override
  void onInit() {
    final image = Get.arguments;
    imageUrl.value = image;
    super.onInit();
  }
}
