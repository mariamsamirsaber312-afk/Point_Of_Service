import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../constants/figma_size.dart';
import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../controller/register_controller.dart';

class RegisterForm extends StatelessWidget {


  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.secondaryBG,
      height: double.infinity,
      child: SingleChildScrollView(
        padding:  EdgeInsets.only(top: FigmaSize.height(context, 124),left: FigmaSize.width(context, 13),right: FigmaSize.width(context, 56),bottom: FigmaSize.height(context,100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello",style: AppTextStyle.loginHelloWorld(context),textAlign: TextAlign.left,),
            Row(children: [Text("Welcome to ",style: AppTextStyle.loginWelcomeLine(context).copyWith(fontWeight: FontWeight.w200)),Text("POS",style: AppTextStyle.loginWelcomeLine(context).copyWith(fontWeight: FontWeight.w400),)],),

            SizedBox(height: 30,),

            TextField(controller: controller.firstNameController,decoration: AppInputDecoration.loginTextField(context, 'First Name',Icons.person),style: AppTextStyle.textFieldStyle(context),),
            TextField(controller: controller.lastNameController,decoration: AppInputDecoration.loginTextField(context, 'Last Name', Icons.person),style: AppTextStyle.textFieldStyle(context),),
            TextField(controller: controller.usernameController,decoration: AppInputDecoration.loginTextField(context, 'User Name', Icons.alternate_email),style: AppTextStyle.textFieldStyle(context),),

            TextField(controller: controller.emailController,decoration: AppInputDecoration.loginTextField(context, 'Email Address', Icons.email_outlined),style: AppTextStyle.textFieldStyle(context),),
            TextField(controller: controller.passwordController,obscureText: true,decoration: AppInputDecoration.loginTextField(context, 'Password', Icons.lock),style: AppTextStyle.textFieldStyle(context)),

            SizedBox(height: 30,),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: FigmaSize.width(context, 80),
                  child:
                  Obx(() => controller.isLoading.value ?
                  const Center(child:  CircularProgressIndicator())
                      :
                  ElevatedButton(
                    onPressed: () {
                      if (controller.emailController.text.isEmpty || controller.passwordController.text.isEmpty) {
                        Get.snackbar("Error", "Please fill all fields");
                        return;
                      }
                      controller.register(controller.firstNameController.text, controller.lastNameController.text, controller.usernameController.text, controller.emailController.text, controller.passwordController.text);
                    },
                    style: AppButtonStyle.loginBtn(context),
                    child:  Text('Register',style: AppTextStyle.loginBtn(context),),
                  ),
                  ),)
            ),

            SizedBox(height: FigmaSize.height(context, 17),),

            Text("Do you have an account ? ",style: AppTextStyle.textFieldStyle(context),),
            GestureDetector(onTap: () => Get.offAllNamed('/login'),child: Text("Login",style: AppTextStyle.textFieldStyle(context).copyWith(color: Colors.blue),),),
          ],
        ),
      ),
    );
  }
}