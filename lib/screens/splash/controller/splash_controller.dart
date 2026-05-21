import 'package:get/get.dart';
import 'package:point_of_service/services/user_storage.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final isLoggedIn = await UserStorage.isLoggedIn();

    await Future.delayed(const Duration(seconds: 5)); // optional splash time

    if (isLoggedIn) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }


}
