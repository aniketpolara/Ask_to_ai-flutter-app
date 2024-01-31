import 'package:asktoai_app/constants/common_colors.dart';
import 'package:flutter/material.dart';

class CommonWidget {
  OutlineInputBorder commonBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(100), borderSide: BorderSide.none);
  Widget textCommon(text) => Text(text.toString(),
      style: const TextStyle(fontSize: 16, color: CommonColors.black));
}
