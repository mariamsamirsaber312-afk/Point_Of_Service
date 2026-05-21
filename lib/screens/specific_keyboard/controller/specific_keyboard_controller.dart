

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_service/screens/payment_method/controller/payment_method_controller.dart';
import 'package:point_of_service/themes/app_color.dart';
import 'package:intl/intl.dart';

class SpecificKeyboardController extends GetxController{

  //for specific keyboard
   //مبلغ الفاتوره
  final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'id', symbol: 'Rp', decimalDigits: 0);

  final payment_controller = Get.put(PaymentMethodController());

  Widget buildKey(String label, {VoidCallback ? onTap, double height = 64 , double width = 95,bool isNumber=true,bool isEmpty=false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 0.5,
        ),

      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: isNumber? AppColor.paymentViewBG:AppColor.primaryBG,
          alignment: Alignment.center,
          height: height,
          child: Text(label, style: TextStyle(fontSize: 24,color: isNumber? Colors.black:Colors.white),),
        ),
      ),
    );
  }

  void append(String value) {
    // نخلي النص عبارة عن أرقام بس (بدون فواصل) ثم نعيد تنسيقه
    String digits = payment_controller.cashController.text.replaceAll(RegExp(r'[^0-9]'), '');
    digits = digits + value;
    // منع الـ leading zeros الطويلة
    digits = digits.replaceFirst(RegExp(r'^0+'), '');
    if (digits.isEmpty) digits = '0';
    _setCashFromDigits(digits);
  }

  void _setCashFromDigits(String digits) {
    // digits يمثل قيمة بدون فورمات، نحول لرقم وننسق
    int val = int.tryParse(digits) ?? 0;
    payment_controller.cashController.text = currencyFormat.format(val);
    _updateChange();
  }


  void _updateChange() {
    int paid = int.tryParse(
        payment_controller.cashController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    int change = paid - payment_controller.totalAmount.toInt();
    if (change < 0) change = 0;
    payment_controller.changeController.text = currencyFormat.format(change);
  }

  void backspace() {
    String digits = payment_controller.cashController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return;
    digits = digits.substring(0, digits.length - 1);
    if (digits.isEmpty) digits = '0';
    _setCashFromDigits(digits);
  }

  void tripleZero() {
    append('000');
  }

  void checkIconPressed(){
    payment_controller.showKeyboard.value = false ;
    _updateChange();
  }
}