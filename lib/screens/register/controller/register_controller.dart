import 'package:get/get.dart';
import '../../../services/auth_services.dart';
import '../../../services/firebase_services.dart';
import '../../../services/user_storage.dart';
import '../../login/model/user_model.dart';
import 'package:flutter/material.dart';


class RegisterController extends GetxController {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  var isLoading = false.obs;
   FirebaseServices? service ;


  Future<void> register(String firstname,String lastname,String username,String email, String password) async {
    try {
      isLoading.value = true;
      final response = await _authService.register(
          firstname: firstname,
          lastname: lastname ,
          username: username,
          email: email,
          password: password

      );
      if (response.statusCode == 200 || response.statusCode == 201) {

        final user = UserModel(
          id: response.data['id'],
          name: response.data['username'], // حسب API
          image: response.data['image'],
          role: response.data['role'],
          token: "token"
        );
        await UserStorage.saveUser(user,response.data['id'].toString());

        service = FirebaseServices(user);
        await service?.addUser(user);

        Get.offAllNamed('/home');
        Get.snackbar("Success", "register successful");

      }else {
        Get.snackbar("Error", "Register failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }


}
