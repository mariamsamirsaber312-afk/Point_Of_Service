import 'package:flutter/material.dart';
import 'package:point_of_service/constants/figma_size.dart';
import 'package:point_of_service/screens/flipped_image/flipped_image.dart';
import 'package:point_of_service/screens/register/view/register_form.dart';
import 'package:point_of_service/themes/app_color.dart';
import 'package:point_of_service/themes/app_text_style.dart';


class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:  Stack(
          children:[
            //[1]row with 2 children left and right side
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
                  child: RegisterForm(),
                )

              ],
            ),

            //[2]tablet image
            FlippedImage()
          ]),

    );
  }


}
