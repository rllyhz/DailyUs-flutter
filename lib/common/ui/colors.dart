import 'package:flutter/material.dart' show Color;

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Color purple200Color = hexToColor("#95A0C3");
Color purple500Color = hexToColor("#8390BA");
Color purple700Color = hexToColor("#52596B");
Color blueColor = hexToColor("#0042FF");
Color greyColor = hexToColor("#F7F8FA");

Color primaryColor = purple500Color;
Color secondaryColor = hexToColor("#FA0000");
Color surfaceColor = const Color(0xFFFFFFFF);
Color hintTextColor = purple200Color;
Color textColor = purple500Color;
Color headingColor = purple700Color;
