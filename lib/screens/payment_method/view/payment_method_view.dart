import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_service/screens/payment_method/controller/payment_method_controller.dart';
import 'package:point_of_service/screens/specific_keyboard/view/specific_keyboard_view.dart';
import 'package:point_of_service/screens/summary/controller/summary_controller.dart';
import 'package:point_of_service/themes/app_color.dart';
import 'package:point_of_service/themes/app_text_style.dart';

class PaymentMethodView extends StatelessWidget {
   PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(PaymentMethodController());
    final summaryController = Get.find<SummaryController>();
    summaryController.onInit();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.paymentViewBG,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.primaryBG,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          color: AppColor.paymentViewBG,
          child: Padding(
            padding: const EdgeInsets.only(top: 70,left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //[1]title of page
                Text('Payment Method',style: AppTextStyle.paymentMethodTitle(context),),
                //[2]payment method buttons
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(() =>
                        Row(
                          children: List.generate(
                            controller.paymentMethods.length,
                                (index) {
                              final method = controller.paymentMethods[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: ElevatedButton(
                                  style: controller.isSelected(index) ? AppButtonStyle.categoryBtnSelected(context):AppButtonStyle.categoryBtn(context),
                                  onPressed: () {
                                    controller.selectPaymentMethod(index);
                                    controller.paymentMethods[index];
                                  },
                                  child: Text(
                                    method,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                    ),
                  ),
                ),

                //[3]total amount
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',style: AppTextStyle.totalCount(context),),
                      Text(summaryController.total.value.toString(),style: AppTextStyle.totalCount(context),)
                    ],
                  ),
                ),

                //[4]cash and change textField
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text('Cash',style: AppTextStyle.cashAndChange(context),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: TextField(decoration: AppInputDecoration.cashAndChange(context, "Rp 100.000"),
                    controller: controller.cashController,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {

                      print('User typed: $value');
                    },
                    onTap: () {
                      controller.showKeyboard.value = true;
                    },

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('Change',style: AppTextStyle.cashAndChange(context),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: TextField(decoration: AppInputDecoration.cashAndChange(context, 'Rp 0'),
                    controller: controller.changeController,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      print('User typed: $value');
                    },
                    onTap: () {
                      controller.showKeyboard.value = true;
                    },
                  ),
                ),

                //[5]custom keyboard

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Obx(() => controller.showKeyboard.value
                      ? Padding(
                    padding: const EdgeInsets.only(top: 30,bottom: 30),
                    child: SpecificKeyboardView(),
                  )
                      : const SizedBox()),
                ),

                  //[6]pay button
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(onPressed: () {
                      controller.onPay();
                    },
                      child: Text('Pay', style: AppTextStyle.loginBtn(context),),
                      style: AppButtonStyle.payBtn(context),),
                  )
              ])
          ),
        ),
      )
    );
  }
}
