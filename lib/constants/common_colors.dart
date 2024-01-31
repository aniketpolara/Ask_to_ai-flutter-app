import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CommonColors {
  //edebdf - background
  //ffffff - textfield
  //058747 - button textfiled
  //c2c0b6 - text copy
  static const colorWhite = Color.fromRGBO(255, 255, 255, 1.0);
  static Color textField = HexColor('ffffff');
  static Color backgroundAppbar = HexColor('058747');
  static Color backgroundDescription = HexColor('edebdf').withOpacity(0.7);
  static Color white54 = Colors.white54;
  static Color white70 = Colors.white70;
  static Color white30 = Colors.white30;
  static const alert = Color.fromRGBO(250, 129, 129, 1.0);
  static const black = Color.fromRGBO(0, 0, 0, 1.0);
  static const blueDark = Color.fromRGBO(5, 19, 40, 1.0);
  static Color background = HexColor('edebdf');
  static const titleTextColor = Color.fromRGBO(253, 253, 253, 1.0);
  static const whiteTransparent01 =
      Color.fromRGBO(208, 208, 208, 0.15294117647058825);
  static const transparent = Color.fromRGBO(255, 255, 255, 0.0);
  static const lightText = Color.fromRGBO(175, 176, 182, 1.0);
  static const greyLight = Color.fromRGBO(50, 52, 68, 0.10196078431372549);
  static const inputFillColor = Color.fromRGBO(245, 245, 246, 1.0);
  static const bg1 = Color.fromRGBO(248, 249, 252, 1.0);
  static const txt = Color.fromRGBO(50, 52, 68, 1.0);
  static const red = Color.fromRGBO(178, 19, 19, 1.0);
  static const red2 = Color.fromRGBO(255, 0, 0, 1.0);
}
