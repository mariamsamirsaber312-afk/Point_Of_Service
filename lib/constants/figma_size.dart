import 'package:flutter/material.dart';

class FigmaSize {
  // figma size
  static const double designWidth = 858;
  static const double designHeight = 802;

  static double _screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide;

  static double _screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;


  // width depend on current screen
  static double width(BuildContext context, double value) {
    final minSide = MediaQuery.of(context).size.shortestSide;
    return (value / designWidth) * minSide;
  }

  // height depend on current screen
  static double height(BuildContext context, double value) {
    final screenHeight = MediaQuery.of(context).size.longestSide;
    return (value / designHeight) * screenHeight;
  }
  // height depend on current screen depend on small dimention height or width
  static double responsiveHeight(BuildContext context, double value) {
    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;
    final baseHeight = isLandscape ? designWidth : designHeight;
    final screenHeight = MediaQuery.of(context).size.height;
    return (value / baseHeight) * screenHeight;
  }

  // width depend on current screen depend on small dimention height or width
  static double responsiveWidth(BuildContext context, double value) {
    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;
    final baseWidth = isLandscape ? designHeight : designWidth;
    final screenWidth = MediaQuery.of(context).size.width;
    return (value / baseWidth) * screenWidth;
  }


  /// Font scaling (أفضل يعتمد على العرض فقط)
  static double font(BuildContext context, double value) {
    return (value /  designWidth) * _screenWidth(context);
  }
}

