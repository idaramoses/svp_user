import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sharkhub/view/signup/controller/signup_controller.dart';

import '../../../data/service_api.dart';
import '../../../res/common/app_button.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/common/app_textfield.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import '../../profile/controller/profile_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpController signUpController = Get.put(SignUpController());
  final ProfileController _profileController = Get.find();
  final SuperbaseService _superbaseService = SuperbaseService();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                children: [
                  Column(
                    children: [
                      CommonMethods.sizedBox(height: 38.h),
                      CommonMethods.appTexts(
                        context,
                        AppText.signup,
                        color: Themes.getTextColor(context),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      CommonMethods.sizedBox(height: 11.h),
                      CommonMethods.appTexts(
                        context,
                        'Enter the details below to continue',
                        color: Themes.getTextColor(context),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      CommonMethods.sizedBox(height: 38.h),
                      AppTextFieldScreen(
                        controller: signUpController.firstnameController,
                        isDense: true,
                        hintText: 'First Name',
                        label:
                        CommonMethods.appTexts(context, 'First Name'),
                        textInputType: TextInputType.text,
                        keyboardType: TextInputAction.next,
                        validator: (val) {
                          if (val!.trim().isNotEmpty) {
                            if (val.trim().isEmpty) {
                              return "Enter your first name";
                            }
                            return null;
                          }
                          return "Enter your name";
                        },
                      ),
                      CommonMethods.sizedBox(height: 24.h),

                      AppTextFieldScreen(
                        controller: signUpController.lastnameController,
                        isDense: true,
                        hintText: 'Last Name',
                        label: CommonMethods.appTexts(context, 'Last Name'),
                        textInputType: TextInputType.text,
                        keyboardType: TextInputAction.next,
                        validator: (val) {
                          if (val!.trim().isNotEmpty) {
                            if (val.trim().isEmpty) {
                              return "Enter your last name";
                            }
                            return null;
                          }
                          return "Enter your last name";
                        },
                      ),
                      CommonMethods.sizedBox(height: 24.h),
                      AppTextFieldScreen(
                        controller: signUpController.emailController,
                        isDense: true,
                        hintText: AppText.emailHint,
                        label: CommonMethods.appTexts(
                          context,
                          AppText.emailHint,
                        ),
                        textInputType: TextInputType.emailAddress,
                        keyboardType: TextInputAction.next,
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            if (!RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(val)) {
                              return "Enter a valid email address";
                            }
                            return null;
                          }
                          return "Enter a valid email address";
                        },
                      ),
                      CommonMethods.sizedBox(height: 24.h),
                      AppTextFieldScreen(
                        controller: signUpController.phoneController,
                        isDense: true,
                        hintText: 'Phone number',
                        label:
                        CommonMethods.appTexts(context, 'Phone number'),
                        textInputType: TextInputType.number,
                        keyboardType: TextInputAction.next,
                        validator: (val) {
                          if (val!.trim().isNotEmpty) {
                            if (val.trim().isEmpty) {
                              return "Enter your Phone number";
                            }
                            return null;
                          }
                          return "Enter your Phone number";
                        },
                      ),
                      CommonMethods.sizedBox(height: 24.h),
                      GetBuilder<SignUpController>(
                        init: SignUpController(),
                        builder: (controller) => AppTextFieldScreen(
                          isDense: true,
                          controller: controller.passwordController,
                          hintText: AppText.password,
                          label: CommonMethods.appTexts(
                            context,
                            AppText.password,
                          ),
                          textInputType: TextInputType.visiblePassword,
                          keyboardType: TextInputAction.done,
                          obscureText: controller.obSecureText.value,
                          maxLines: 1,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.obSecureText.value =
                              !controller.obSecureText.value;
                              controller.update();
                            },
                            hoverColor: Colors.black,
                            icon: CommonMethods.imagesOfApp(
                              controller.obSecureText.value
                                  ? AppImages.hidePass
                                  : AppImages.eyeLogin,

                              height: 24.h,
                              width: 24.h,
                            ),
                          ),
                          validator: (val) {
                            if (val!.trim().isNotEmpty) {
                              if (val.trim().isEmpty) {
                                return "Enter a valid password";
                              } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
                                  .hasMatch(val.trim())) {
                                return "Password must contain capital,small letters and numbers";
                              } else if (val.trim().length < 8) {
                                return "Password must be more than 8 characters";
                              } else if (controller
                                  .passwordController.text !=
                                  controller
                                      .confirmpasswordController.text) {
                                return "Password are not the same";
                              }
                              return null;
                            }
                            return "Enter a valid password";
                          },
                        ),
                      ),
                      CommonMethods.sizedBox(height: 30.h),
                      GetBuilder<SignUpController>(
                        init: SignUpController(),
                        builder: (controller) => AppTextFieldScreen(
                          isDense: true,
                          controller: controller.confirmpasswordController,
                          hintText: 'Confirm Password',
                          label: CommonMethods.appTexts(
                            context,
                            'Confirm Password',
                          ),
                          textInputType: TextInputType.visiblePassword,
                          keyboardType: TextInputAction.done,
                          obscureText: controller.obSecureText.value,
                          maxLines: 1,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.obSecureText.value =
                              !controller.obSecureText.value;
                              controller.update();
                            },
                            hoverColor: Colors.black,
                            icon: CommonMethods.imagesOfApp(
                              controller.obSecureText.value
                                  ? AppImages.hidePass
                                  : AppImages.eyeLogin,

                              height: 24.h,
                              width: 24.h,
                            ),
                          ),
                          validator: (val) {
                            if (val!.trim().isNotEmpty) {
                              if (val.trim().isEmpty) {
                                return "Enter a valid password";
                              } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
                                  .hasMatch(val.trim())) {
                                return "Password must contain capital,small letters and numbers";
                              } else if (val.trim().length < 8) {
                                return "Password must be more than 8 characters";
                              } else if (controller
                                  .passwordController.text !=
                                  controller
                                      .confirmpasswordController.text) {
                                return "Password are not the same";
                              }
                              return null;
                            }
                            return "Enter a valid password";
                          },
                        ),
                      ),
                      CommonMethods.sizedBox(height: 30.h),
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
                                'https://www.sparkhub.ng/api/auth/register');
                            // Your JSON data
                            var data = {
                              'firstname': signUpController
                                  .firstnameController.text,
                              'lastname': signUpController
                                  .lastnameController.text,
                              'email': signUpController
                                  .emailController.text,
                              'phone': signUpController
                                  .phoneController.text,
                              'password': signUpController
                                  .passwordController.text,
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
                                      headers: headers,
                                      body: jsonData);
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
                                // Get.snackbar(
                                //   'Success',
                                //   'Signup successful',
                                //   snackPosition: SnackPosition.TOP,
                                //   colorText: Colors.white,
                                //   backgroundColor: Colors.green,
                                //   duration: Duration(seconds: 1),
                                // );
                                CommonMethods.sendToNextScreen(
                                    context, RoutesPath.verifyEmail);
                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                // If the server did not return a 200 OK response,
                                // print the response status and body
                                setState(() {
                                  isLoading = false;
                                });
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
                                print(
                                    'Error - Body: ${response.body}');
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
                        child: AppButton(
                          text: isLoading
                              ? 'Logging in...'
                              : AppText.signup,
                        ),
                      ),
                      CommonMethods.sizedBox(height: 16.h),
                      // CommonMethods.appTexts(
                      //   context,
                      //   AppText.or,
                      //   color: Themes.getTextColor(context),
                      //   fontSize: 18.sp,
                      //   fontWeight: FontWeight.w600,
                      // ),
                      // CommonMethods.sizedBox(height: 16.h),
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 54.h,
                      //       width: 190.w,
                      //       decoration: CommonMethods.getBoxDecoration(
                      //         cornerRadius: 30.r,
                      //         color: Themes.getCardColor(context),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           CommonMethods.imagesOfApp(
                      //             AppImages.google,
                      //             height: 24.h,
                      //             width: 24.h,
                      //           ),
                      //           CommonMethods.sizedBox(width: 16.w),
                      //           CommonMethods.appTexts(
                      //             context,
                      //             AppText.google,
                      //             color: Themes.getTextColor(context),
                      //             fontSize: 18.sp,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     // CommonMethods.sizedBox(width: 16.w),
                      //     // Container(
                      //     //   height: 54.h,
                      //     //   width: 190.w,
                      //     //   decoration: CommonMethods.getBoxDecoration(
                      //     //     cornerRadius: 30.r,
                      //     //     color: Themes.getCardColor(context),
                      //     //   ),
                      //     //   child: Row(
                      //     //     mainAxisAlignment: MainAxisAlignment.center,
                      //     //     children: [
                      //     //       CommonMethods.imagesOfApp(
                      //     //         AppImages.apple,
                      //     //         height: 24.h,
                      //     //         width: 24.h,
                      //     //       ),
                      //     //       CommonMethods.sizedBox(width: 16.w),
                      //     //       CommonMethods.appTexts(
                      //     //         context,
                      //     //         AppText.apple,
                      //     //         color: Themes.getTextColor(context),
                      //     //         fontSize: 18.sp,
                      //     //         fontWeight: FontWeight.w600,
                      //     //       ),
                      //     //     ],
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
                    ],
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: AppText.already,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF Pro Display',
                          color: Themes.getTextColor(context),
                        ),
                        children: [
                          TextSpan(
                            text: AppText.signIn,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                debugPrint('SUCCESS======');
                                CommonMethods.sendToNextScreen(
                                    context, RoutesPath.loginPage);
                              },
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400,
                              color: Themes.getPrimaryColor(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
