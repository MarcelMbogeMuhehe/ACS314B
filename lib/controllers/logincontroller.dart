import 'package:get/get.dart';

class LoginController extends GetxController {
 

  var isPasswordVisible = false.obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
