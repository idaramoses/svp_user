import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxBool obSecureText = true.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    phoneController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
  }

  void clearText() {
    emailController.clear();
    passwordController.clear();
    firstnameController.clear();
    confirmpasswordController.clear();
    phoneController.clear();
    lastnameController.clear();
    update();
  }
}
