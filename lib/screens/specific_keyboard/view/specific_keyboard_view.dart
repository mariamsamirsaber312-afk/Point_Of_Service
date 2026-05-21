import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:point_of_service/screens/specific_keyboard/controller/specific_keyboard_controller.dart';

import '../../../themes/app_color.dart';

class SpecificKeyboardView extends StatelessWidget {
  const SpecificKeyboardView({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SpecificKeyboardController());

    return Container(
      color: AppColor.paymentViewBG,
      padding:const EdgeInsets.only(top: 30),


      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // numeric grid

          Expanded(
            flex: 3,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 2.5,
              physics: NeverScrollableScrollPhysics(),
              children: [
                controller.buildKey('1', onTap: () => controller.append('1'),height: 64,width: 95),
                controller.buildKey('2', onTap: () => controller.append('2'),height: 64,width: 95),
                controller.buildKey('3', onTap: () => controller.append('3'),height: 64,width: 95),
                controller.buildKey('',height: 64,width: 95),
                controller.buildKey('4', onTap: () => controller.append('4'),height: 64,width: 95),
                controller.buildKey('5', onTap: () => controller.append('5'),height: 64,width: 95),
                controller.buildKey('6', onTap: () => controller.append('6'),height: 64,width: 95),
                controller.buildKey('',height: 64,width: 95),
                controller.buildKey('7', onTap: () => controller.append('7'),height: 64,width: 95),
                controller.buildKey('8', onTap: () => controller.append('8'),height: 64,width: 95),
                controller.buildKey('9', onTap: () => controller.append('9'),height: 64,width: 95),
                controller.buildKey('⌫', onTap: () => controller.backspace(),height: 64,width: 95,isNumber: false),
                controller.buildKey('000', onTap: () => controller.tripleZero(),height: 64,width: 95),
                controller.buildKey('0', onTap: () => controller.append('0'),height: 64,width: 95),
                controller.buildKey('',height: 64,width: 95),
                controller.buildKey('✔',onTap: controller.checkIconPressed,height: 94,width: 95,isNumber: false)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
