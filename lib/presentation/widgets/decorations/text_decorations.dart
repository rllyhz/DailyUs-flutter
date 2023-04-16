import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart' show appTextStyle;
import 'package:flutter/material.dart'
    show TextStyle, FontWeight, Color, Colors;

TextStyle buttonTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regularFontWeight,
      color: color ?? surfaceColor,
    );

TextStyle hintTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regularFontWeight,
      color: color ?? surfaceColor,
    );

TextStyle splashTextStyle({
  double fontSize = 28.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? mediumFontWeight,
      color: color ?? purple500Color,
    );

TextStyle onBoardingAppNameTextStyle({
  double fontSize = 20.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? mediumFontWeight,
      color: color ?? secondaryColor,
    );

TextStyle onBoardingHeadlineTextStyle({
  double fontSize = 20.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? mediumFontWeight,
      color: color ?? purple700Color,
    );

TextStyle titleTextStyle({
  double fontSize = 22.0,
  FontWeight? fontWeight,
  Color? color,
  bool inverse = false,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? mediumFontWeight,
      color: inverse ? (color ?? Colors.white) : (color ?? purple700Color),
    );

TextStyle homeGreetingUserTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regularFontWeight,
      color: color ?? purple500Color,
    );

TextStyle homeGreetingHeadlineTextStyle({
  double fontSize = 19.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? mediumFontWeight,
      color: color ?? purple700Color,
    );

TextStyle homeCardFullNameTextStyle({
  double fontSize = 20.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? mediumFontWeight,
      color: color ?? purple700Color,
    );

TextStyle homeCardDateTextStyle({
  double fontSize = 16.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? lightFontWeight,
      color: color ?? purple500Color,
    );

TextStyle homeCardDescriptionTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regularFontWeight,
      color: color ?? purple700Color,
    );

TextStyle profileEmailTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regularFontWeight,
      color: color ?? purple500Color,
    );

TextStyle profileFullNameTextStyle({
  double fontSize = 24.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? mediumFontWeight,
      color: color ?? purple700Color,
    );

TextStyle detailFullNameTextStyle({
  double fontSize = 20.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? mediumFontWeight,
      color: color ?? purple700Color,
    );

TextStyle detailDateTextStyle({
  double fontSize = 16.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? lightFontWeight,
      color: color ?? purple500Color,
    );

TextStyle detailDescriptionTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regularFontWeight,
      color: color ?? purple700Color,
    );

TextStyle detailCoordinatesLabelTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? mediumFontWeight,
      color: color ?? purple700Color,
    );

TextStyle detailCoordinatesValueTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regularFontWeight,
      color: color ?? purple500Color,
    );

TextStyle postPhotoPreviewLabelTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regularFontWeight,
      color: color ?? purple500Color,
    );

TextStyle postDescriptionTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    postPhotoPreviewLabelTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );

TextStyle postShareLocationTextStyle({
  double fontSize = 18.0,
  FontWeight? fontWeight,
  Color? color,
}) =>
    appTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regularFontWeight,
      color: color ?? purple500Color,
    );
