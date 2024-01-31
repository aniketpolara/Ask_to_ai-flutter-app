import 'dart:developer';

import 'package:asktoai_app/constants/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';

class ChatMessageViewLayout extends StatelessWidget {
  const ChatMessageViewLayout({
    Key? key,
    required this.text,
    required this.isCurrentUser,
  }) : super(key: key);
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isCurrentUser
                ? CommonColors.backgroundAppbar
                : CommonColors.textField,
            borderRadius: isCurrentUser
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: isCurrentUser
                ? Text(
                    text,
                    style: const TextStyle(color: CommonColors.colorWhite),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          text,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: HexColor("000000"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Share.share(text);
                        },
                        child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 5),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: CommonColors.backgroundDescription,
                                borderRadius: BorderRadius.circular(4)),
                            child: SvgPicture.asset(
                                // ignore: deprecated_member_use
                                color: HexColor("000000"),
                                'assets/icons/share.svg')),
                      ),
                      InkWell(
                        onTap: () {
                          log(text);
                          Get.snackbar(
                            "Copy",
                            "Copy to Clipboard Successfully ",
                            snackPosition: SnackPosition.TOP,
                            colorText: CommonColors.black,
                            backgroundColor: CommonColors.colorWhite,
                            borderRadius: 10,
                          );
                          Clipboard.setData(ClipboardData(text: text));
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: CommonColors.backgroundDescription,
                                borderRadius: BorderRadius.circular(4)),
                            child: SvgPicture.asset(
                              // ignore: deprecated_member_use
                              color: HexColor("000000"),
                              'assets/icons/copy.svg',
                            )),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
