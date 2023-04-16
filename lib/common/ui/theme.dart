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
        InkWell,
        Ink,
        CircularProgressIndicator;
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

InkWell appButton({
  String? text,
  void Function()? onPressed,
  EdgeInsets? padding,
  Color? backgroundColor,
  Color? color,
  bool showLoadingState = false,
}) =>
    InkWell(
      onTap: showLoadingState ? null : onPressed,
      splashColor: Colors.white.withOpacity(0.3),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Ink(
        padding: padding ?? const EdgeInsets.all(14.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: backgroundColor ?? secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
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

InkWell appOutlinedButton({
  String? text,
  void Function()? onPressed,
  EdgeInsets? padding,
  Color? borderColor,
  Color? color,
}) =>
    InkWell(
      onTap: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Ink(
        padding: padding ?? const EdgeInsets.all(14.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: borderColor ?? primaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Center(
          child: Text(
            text ?? "",
            style: buttonTextStyle(color: color ?? secondaryColor),
          ),
        ),
      ),
    );
