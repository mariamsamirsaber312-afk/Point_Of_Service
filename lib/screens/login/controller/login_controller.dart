import 'package:get/get.dart';
import 'package:point_of_service/services/firebase_services.dart';
import '../../../services/auth_services.dart';
import '../../../services/user_storage.dart';
import '../model/user_model.dart';
import 'package:flutter/material.dart';


class LoginController extends GetxController {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  var isLoading = false.obs;
  FirebaseServices? service ;

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      final response = await _authService.login(
        username: username,
        password: password,
      );
      if (response.statusCode == 200) {

        final user = UserModel(
          id: response.data['id'],
          name: response.data['username'], // حسب API
          image: response.data['image'],
          role: response.data['role'] ?? "",
          token: "token"
        );
        await UserStorage.saveUser(user,response.data['accessToken']);

        service = FirebaseServices(user);
        await service?.addUser(user);

        Get.offAllNamed('/home');
        Get.snackbar("Success", "Login successful");

      }else {
        Get.snackbar("Error", "Login failed");
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
