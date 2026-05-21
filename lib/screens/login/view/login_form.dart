import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/figma_size.dart';
import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../controller/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LoginController());

    return Container(
      color: AppColor.secondaryBG,
      height: double.infinity,
      child: SingleChildScrollView(
        padding:  EdgeInsets.only(top: FigmaSize.height(context, 124),left: FigmaSize.width(context, 13),right: FigmaSize.width(context, 56),bottom: FigmaSize.height(context, 224)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello",style: AppTextStyle.loginHelloWorld(context),textAlign: TextAlign.left,),
            Row(children: [Text("Welcome to ",style: AppTextStyle.loginWelcomeLine(context).copyWith(fontWeight: FontWeight.w200)),Text("POS",style: AppTextStyle.loginWelcomeLine(context).copyWith(fontWeight: FontWeight.w400),)],),

            SizedBox(height: 30,),

            TextField(controller: controller.emailController,decoration: AppInputDecoration.loginTextField(context, "Email Address", Icons.email_outlined),style: AppTextStyle.textFieldStyle(context),),
            TextField(controller: controller.passwordController,obscureText: true,decoration: AppInputDecoration.loginTextField(context, "Password", Icons.lock),style: AppTextStyle.textFieldStyle(context)),

            SizedBox(height: 30,),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: FigmaSize.width(context, 80),
                  child:
                  Obx(() => controller.isLoading.value ?
                  const Center(child:CircularProgressIndicator())
                      :
                  ElevatedButton(
                    onPressed: () {
                      controller.login(controller.emailController.text, controller.passwordController.text);
                    },
                    style: AppButtonStyle.loginBtn(context),
                    child:  Text('Login',style: AppTextStyle.loginBtn(context),),
                  ),
                  ),)
            ),

            SizedBox(height: FigmaSize.height(context, 17),),

            Center(child: Text("Forget password",style: AppTextStyle.textFieldStyle(context),)),

            SizedBox(height: FigmaSize.height(context, 17),),

            Text("Don't have an account ? ",style: AppTextStyle.textFieldStyle(context),),
            GestureDetector(onTap: () => Get.offAllNamed('/register'),child: Text("Register",style: AppTextStyle.textFieldStyle(context).copyWith(color: Colors.blue),),),
          ],
        ),
      ),
    );
  }
}




