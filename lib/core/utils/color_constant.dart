import 'dart:ui';

import 'package:flutter/material.dart';

class ColorConstant {
  static Color lime700 = fromHex('#caab3a');

  static Color gray600 = fromHex('#727272');

  static Color gray50 = fromHex('#fffcf4');

  static Color gray400 = fromHex('#c6c6c6');

  static Color gray500 = fromHex('#9b9b9b');

  static Color orangeA200 = fromHex('#e1a450');

  static Color gray800 = fromHex('#3e3e3e');

  static Color lightGreenA700 = fromHex('#44c000');

  static Color blue600 = fromHex('#2d9cdb');

  static Color gray80026 = fromHex('#26534617');

  static Color red500 = fromHex('#ff3838');

  static Color gray200 = fromHex('#f0f0f0');

  static Color gray300 = fromHex('#dddddd');

  static Color gray100 = fromHex('#f3f3f3');

  static Color black900 = fromHex('#000000');

  static Color bluegray400 = fromHex('#888888');

  static Color orangeA200A2 = fromHex('#a2e1a450');

  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
