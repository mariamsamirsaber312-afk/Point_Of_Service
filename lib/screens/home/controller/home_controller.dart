

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_service/themes/app_color.dart';

class HomeController extends GetxController{

  RxInt selectedIndex = 0.obs ; // 0= POS ,1 = Summary

  Color get appBarColor {
    switch (selectedIndex.value) {
      case 0:
        return Colors.transparent;
      case 1:
        return AppColor.paymentViewBG;
      default:
        return Colors.transparent;
    }
  }


}