import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart'
    show
        ThemeData,
        ColorScheme,
        TextTheme,
        TextStyle,
        Colors,
        CircularProgressIndicator,
        MaterialStateProperty,
        RoundedRectangleBorder,
        OutlinedButton,
        TextButton,
        ButtonStyle;
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

TextButton appButton({
  String? text,
  void Function()? onPressed,
  EdgeInsets? padding,
  Color? backgroundColor,
  Color? color,
  bool showLoadingState = false,
}) =>
    TextButton(
      onPressed: showLoadingState ? null : onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(backgroundColor ?? secondaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: showLoadingState
              ? CircularProgressIndicator(
                  strokeWidth: 3.0,
                  color: color ?? surfaceColor,
                )
              : Text(
                  text ?? "",
                  style: buttonTextStyle(color: color),
                ),
        ),
      ),
    );

OutlinedButton appOutlinedButton({
  String? text,
  void Function()? onPressed,
  EdgeInsets? padding,
  Color? borderColor,
  Color? color,
}) =>
    OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            side: BorderSide(
              color: borderColor ?? greyColor,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Center(
          child: Text(
            text ?? "",
            style: buttonTextStyle(color: color ?? secondaryColor),
          ),
        ),
      ),
    );
