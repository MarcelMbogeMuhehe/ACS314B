import 'package:get/get.dart';

class Signupcontroller extends GetxController {

  var isPasswordVisible = false.obs;

  
  var isConfirmPasswordVisible = false.obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPassword() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }
}
