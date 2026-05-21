import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_service/constants/figma_size.dart';
import 'package:point_of_service/screens/login/view/login_form.dart';
import 'package:point_of_service/themes/app_color.dart';
import 'package:point_of_service/themes/app_text_style.dart';
import '../../flipped_image/flipped_image.dart';
import '../controller/login_controller.dart';

class LoginView extends StatelessWidget {
   LoginView({super.key});

  // final controller = Get.put(LoginController());

   @override
   Widget build(BuildContext context) {

     return Scaffold(
      body:  Stack(
            children:[
             Row(
                children: [
                  //left side
                  Expanded(
                    flex: 2,
                    child: Container(color: AppColor.primaryBG,
                      child: Padding(
                        padding:  EdgeInsets.only(top: FigmaSize.height(context, 50)),
                        child: Align(alignment: Alignment.topCenter,
                            child: Text("LOGO",style: AppTextStyle.headlineLarge(context))),
                      ),
                    ),
                  ),
                  //right side
                  Expanded(
                      flex: 3,
                      child: LoginForm(),
                      )
                ],
             ),

              //tablet image
              FlippedImage()

          ]),

      );
  }
}
