import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PaymentMethodController extends GetxController{



  RxList<String> paymentMethods = <String>[].obs;
  RxInt selectedIndex = 0.obs;


  final TextEditingController cashController = TextEditingController();
  final TextEditingController changeController = TextEditingController();
  final RxBool showKeyboard = false.obs;
  final RxDouble totalAmount = 25000.0.obs;





  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadPaymentMethod();
  }

  void loadPaymentMethod() {
    paymentMethods.value = [
      "Cash",
      "QRIS",
      "Debit",
    ];
  }

  void selectPaymentMethod(int index) {
    selectedIndex.value = index;
  }

  bool isSelected(int index) {
    return selectedIndex.value == index;
  }


  void dipose() {
    cashController.dispose();
    changeController.dispose();
    super.dispose();
  }



  void onPay() {
    // مثال: تنفيذ الدفع
    int paid = int.tryParse(
        cashController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    if (paid < totalAmount.value) {
      Get.snackbar('تنبيه', 'المبلغ غير كاف');
      return;
    }
    // تابع عملية الدفع...
    Get.snackbar( 'تم','تم الدفع');
  }








}