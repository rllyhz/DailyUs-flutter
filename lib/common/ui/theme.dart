import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:flutter/material.dart'
    show ThemeData, ColorScheme, TextTheme, TextStyle, Colors;
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

final themeLight = ThemeData.light().copyWith(
  hintColor: hintTextColor,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    onSecondary: Colors.white,
  ),
  textTheme: TextTheme(
    bodySmall: TextStyle(color: textColor),
  ),
);

TextStyle appTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) =>
    GoogleFonts.poppins(
      color: color ?? defaultTextColor,
      fontSize: fontSize ?? lightFontSize,
      fontWeight: fontWeight ?? lightFontWeight,
    );
