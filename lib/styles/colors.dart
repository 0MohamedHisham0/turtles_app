import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

var seaColor = HexColor('00BDE7').withOpacity(10);
var wildColor = HexColor('26AC64');

const defaultColorSea = MaterialColor(
  0xFF00BDE7,
  <int, Color>{
    50: Color(0xFF00BDE7),
    100: Color(0xFF00BDE7),
    200: Color(0xFF00BDE7),
    300: Color(0xFF00BDE7),
    400: Color(0xFF00BDE7),
    500: Color(0xFF00BDE7),
    600: Color(0xFF00BDE7),
    700: Color(0xFF00BDE7),
    800: Color(0xFF00BDE7),
    900: Color(0xFF00BDE7),
  },
);
const defaultColorWild = MaterialColor(
  0xFF26AC64,
  <int, Color>{
    50: Color(0xFF26AC64),
    100: Color(0xFF1BA95D),
    200: Color(0xFF0CB65B),
    300: Color(0xFF0EB75C),
    400: Color(0xFF26AC64),
    500: Color(0xFF26AC64),
    600: Color(0xFF26AC64),
    700: Color(0xFF26AC64),
    800: Color(0xFF26AC64),
    900: Color(0xFF26AC64),
  },
);

var defaultColor = defaultColorWild;
