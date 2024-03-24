import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool obSecureText = true.obs;
  RxString password = "".obs;
  RxString email = "".obs;
  RxBool borderColor = true.obs;

  TextEditingController forgotEmailController = TextEditingController();

  TextEditingController pinController = TextEditingController();
  final pinForm = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool newObSecureText = true;
  bool reEnterPass = true;
  RxString passwordCreate = "".obs;
  RxString reenterPassword = "".obs;
  RxBool passwordFieldColor = true.obs;
  RxBool confirmPassFieldColor = true.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.clear();
    passwordController.clear();
    forgotEmailController.clear();
    pinController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  void clearText() {
    emailController.clear();
    passwordController.clear();
    forgotEmailController.clear();
    pinController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    update();
  }
}
