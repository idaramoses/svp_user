import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharkhub/view/login/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValidatePin extends StatefulWidget {
  const ValidatePin({super.key});

  @override
  State<ValidatePin> createState() => _ValidatePinState();
}

class _ValidatePinState extends State<ValidatePin> {
  LogInController logInController = Get.put(LogInController());

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final Dio _dio = Dio();
  Future<void> signup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", logInController.emailController.text);
    prefs.setString("password", logInController.passwordController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    signup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return exit(0);
      },
      child:Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding:
              EdgeInsets.only(bottom: 40.h, left: 16.h, right: 16.h),
            ),
          ),
        ),
      ),
    );
  }

  // Future<Map<String, dynamic>> login(String username, String password) async {
  //   try {
  //     final response = await _dio.post(
  //       'https://example.com/api/login',
  //       data: {
  //         'email': username,
  //         'password': password,
  //       },
  //     );
  //
  //     // Assuming the API returns a JSON object
  //     return response.data;
  //   } catch (error) {
  //     // Handle error
  //     print('Error during login: $error');
  //   }
  // }
}
