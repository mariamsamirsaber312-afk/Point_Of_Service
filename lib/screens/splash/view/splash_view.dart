import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_service/themes/app_color.dart';
import 'package:point_of_service/themes/app_text_style.dart';
import '../../../constants/figma_size.dart';
import '../../flipped_image/flipped_image.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
   SplashView({super.key});

   final SplashController controller = Get.put(SplashController());

   @override
  Widget build(BuildContext context) {


     return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColor.primaryBG, // purple background
        child: Stack(
          children: [

            ///[1] LOGO
            Positioned(
              top: FigmaSize.height(context, 40),
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'LOGO',
                  style:AppTextStyle.headlineLarge(context)
                ),
              ),
            ),

            Positioned(
                top: FigmaSize.responsiveHeight(context, 500),
                left: FigmaSize.responsiveWidth(context, -50),
                right: FigmaSize.responsiveWidth(context, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                ///[2] Tablet Image
                    FlippedImage(top: 0,left: 0,),

                ///[3] Text Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 0,left: 0),
                      child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children:  [
                            TextSpan(text: 'One POS App for ',style: AppTextStyle.splash(context,fontWeight: FontWeight.w400)),
                            TextSpan(
                              text: 'All Types of Businesses',
                              style: AppTextStyle.splash(context,fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ])
            ),
          ],
        ),
      ),
    );
  }
}
