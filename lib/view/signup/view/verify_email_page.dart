import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sharkhub/view/signup/controller/signup_controller.dart';

import '../../../data/pref_data.dart';
import '../../../data/service_api.dart';
import '../../../res/common/app_button.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../utils/themes.dart';
import '../../profile/controller/profile_controller.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  SignUpController signUpController = Get.put(SignUpController());
  final ProfileController _profileController = Get.find();
  final SuperbaseService _superbaseService = SuperbaseService();
  bool isLoading = false;
  final Dio _dio = Dio();

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    return  Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: CommonMethods.nullAppBar(
        context,
        statusBarColor: Themes.getScaffoldColor(context),

      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding:
              EdgeInsets.only(bottom: 40.h, left: 16.h, right: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonMethods.sizedBox(height: 25.h),
                  Container(
                    width: 120.h, // Adjust the size as needed
                    height: 120.h, // Adjust the size as needed
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   border: Border.all(
                    //     color: Colors.green,
                    //     width: 4.0,
                    //   ),
                    // ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.mail,
                        color: Themes.getPrimaryColor(context),
                        size: 100.h,
                      ),
                    ),
                  ),
                  CommonMethods.sizedBox(height: 15.h),
                  Text(
                    'Verify email',
                    style: TextStyle(
                      color: Themes.getTextColor(context),
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  CommonMethods.sizedBox(height: 7.h),
                  Text(
                    'Enter the 6 digit code sent to your email',
                    style: TextStyle(
                      color: Themes.getTextColor(context),
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  CommonMethods.sizedBox(height: 10.h),
                  Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      appContext: context,
                      controller: pinController,
                      length: 6,
                      obscureText: false,
                      cursorColor: Colors.black,
                      textStyle: TextStyle(
                        color: Themes.getTextColor(context),
                      ),
                      hintStyle: TextStyle(
                        color: Themes.getTextColor(context),
                      ),
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      scrollPadding: const EdgeInsets.all(10),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        // fieldHeight: 50,
                        // fieldWidth: 40,
                        activeFillColor: Colors.black,
                        inactiveColor: Colors.grey,
                      ),
                      // validator: (v) {
                      //   if (v!.length < 6) {
                      //     return "fills not complete";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      onChanged: (value) {
                        // Handle changes in the entered PIN
                        print(value);
                      },
                    ),
                  ),
                  CommonMethods.sizedBox(height: 60.h),
                  isLoading
                      ? Container(
                      height: 54.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64.r),
                        color: Themes.getPrimaryColor(context),
                      ),
                      child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          )))
                      : GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        var url = Uri.parse(
                            'https://www.sparkhub.ng/api/auth/verify');
                        // Your JSON data
                        var data = {
                          'email':
                          signUpController.emailController.text,
                          'token': pinController.text,
                          'type': 'email',
                        };

                        // Convert the data to JSON format
                        var jsonData = jsonEncode(data);

                        // Set the headers
                        var headers = {
                          'Content-Type': 'application/json'
                        };

                        // Create an http.Client to handle redirects
                        var client = http.Client();

                        try {
                          var response = await client.post(url,
                              headers: headers, body: jsonData);

                          // Check for redirects manually
                          while (response.statusCode == 308 ||
                              response.statusCode == 301 ||
                              response.statusCode == 302) {
                            var redirectUrl =
                            response.headers['location'];
                            if (redirectUrl != null) {
                              url = Uri.parse(redirectUrl);
                              response = await client.post(url,
                                  headers: headers, body: jsonData);
                            } else {
                              print(
                                  'Error - Redirect location not found.');
                              break;
                            }
                          }

                          // Check the final response status
                          if (response.statusCode == 200) {
                            // If the server returns a 200 OK response,
                            // parse the JSON response
                            Get.snackbar(
                              'Success',
                              'Verify successful',
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.white,
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 1),
                            );
                            PrefData.deletedata();
                            CommonMethods.sendToNextScreen(
                                context, RoutesPath.loginPage);
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            // If the server did not return a 200 OK response,
                            // print the response status and body
                            setState(() {
                              isLoading = false;
                            });
                            print('Error - Body: ${response.body}');
                            Get.snackbar(
                              'Error',
                              '${response.body}',
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            );
                            // print(
                            //     'Error - Status Code: ${response.statusCode}');
                            print('Error - Body: ${response.body}');
                          }
                        } catch (e) {
                          // Handle any exceptions that may occur during the request
                          print('Error: $e');
                        } finally {
                          // Close the client when done
                          client.close();
                        }
                      }
                    },
                    child: const AppButton(
                      text: 'Verify OTP',
                    ),
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
