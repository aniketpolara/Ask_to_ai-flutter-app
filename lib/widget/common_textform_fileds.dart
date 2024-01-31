import 'package:asktoai_app/constants/common_colors.dart';
import 'package:flutter/material.dart';

class CommonTextFormFiled extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final Color? textColor;
  final bool obscureText;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final int? maxLength, minLines;

  const CommonTextFormFiled(
      {Key? key,
      required this.hintText,
      this.validator,
      this.controller,
      this.suffixIcon,
      this.prefixIcon,
      this.textColor,
      this.border,
      this.obscureText = false,
      this.fillColor,
      this.keyboardType,
      this.focusNode,
      this.onChanged,
      this.maxLength,
      this.minLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Text field common
    return TextFormField(
        style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        onChanged: onChanged,
        minLines: minLines,
        maxLength: maxLength,
        decoration: InputDecoration(
            fillColor: fillColor ?? CommonColors.inputFillColor,
            filled: true,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 0, style: BorderStyle.none)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
            hintText: hintText));
  }
}
