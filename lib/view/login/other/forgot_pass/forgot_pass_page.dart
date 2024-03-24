import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sharkhub/view/login/controller/login_controller.dart';

import '../../../../main.dart';
import '../../../../res/common/app_button.dart';
import '../../../../res/common/app_methods.dart';
import '../../../../res/common/app_textfield.dart';
import '../../../../res/constant/app_routes_path.dart';
import '../../../../res/constant/app_strings.dart';
import '../../../../utils/themes.dart';
import '../../../signup/controller/signup_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final forgotFormKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late String access_token;
  bool isLoading = false;
  bool issend = false;
  bool isverify = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonMethods.appBar(
          backgroundColor: Themes.getCardColor(context),
          onTap: () {
            CommonMethods.jumpOutFromScreen(context);
          },
          title: CommonMethods.appTexts(
            context,
            AppText.forgotPass,
            color: Themes.getTextColor(context),
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: GetBuilder(
          builder: (loginController) {
            return SafeArea(
              child: issend
                  ? Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      CommonMethods.sizedBox(height: 16.h),
                      CommonMethods.appTexts(
                        context,
                        'Input the OTP sent to ${emailController.text}',
                        textAlign: TextAlign.center,
                        color: Themes.getTextColor(context),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      CommonMethods.sizedBox(height: 36.h),
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
                            borderRadius:
                            BorderRadius.circular(64.r),
                            color:
                            Themes.getPrimaryColor(context),
                          ),
                          child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )))
                          : GestureDetector(
                        onTap: () async {
                          if (pinController.text.length == 6) {
                            setState(() {
                              isLoading = true;
                            });
                            var url = Uri.parse(
                                'https://www.sparkhub.ng/api/auth/verify');
                            // Your JSON data
                            var data = {
                              'email': emailController.text,
                              'token': pinController.text,
                              'type': 'recovery',
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
                              var response = await client.post(
                                  url,
                                  headers: headers,
                                  body: jsonData);

                              // Check for redirects manually
                              while (response.statusCode ==
                                  308 ||
                                  response.statusCode == 301 ||
                                  response.statusCode == 302) {
                                var redirectUrl = response
                                    .headers['location'];
                                if (redirectUrl != null) {
                                  url = Uri.parse(redirectUrl);
                                  response = await client.post(
                                      url,
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
                                var jsonResponse =
                                jsonDecode(response.body);
                                print(
                                    'token: -------${jsonResponse['access_token']}');
                                Get.snackbar(
                                  'Success',
                                  'Verify successful',
                                  snackPosition:
                                  SnackPosition.TOP,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.green,
                                  duration:
                                  Duration(seconds: 1),
                                );
                                setState(() {
                                  isLoading = false;
                                  isverify = true;
                                  issend = false;
                                  access_token =
                                  '${jsonResponse['access_token']}';
                                });
                              } else {
                                // If the server did not return a 200 OK response,
                                // print the response status and body
                                setState(() {
                                  isLoading = false;
                                });
                                print(
                                    'Error - Body: ${response.body}');
                                Get.snackbar(
                                  'Error',
                                  '${response.body}',
                                  snackPosition:
                                  SnackPosition.TOP,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                  duration:
                                  Duration(seconds: 2),
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
                        child: const AppButton(
                          text: 'Verify OTP',
                        ),
                      ),
                      CommonMethods.sizedBox(height: 30.h),
                      RichText(
                        text: TextSpan(
                          text: "Didn't receive code?",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SF Pro Display',
                            color: Themes.getTextColor(context),
                          ),
                          children: [
                            TextSpan(
                              text: AppText.resend,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  postData(loginController
                                      .forgotEmailController.text);
                                },
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w600,
                                color:
                                Themes.getPrimaryColor(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : isverify
                  ? Form(
                key: updateFormKey,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      CommonMethods.sizedBox(height: 16.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20),
                        child: CommonMethods.appTexts(
                          context,
                          'Update your password',
                          textAlign: TextAlign.center,
                          color: Themes.getTextColor(context),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      CommonMethods.sizedBox(height: 20.h),
                      GetBuilder<SignUpController>(
                        init: SignUpController(),
                        builder: (controller) =>
                            AppTextFieldScreen(
                              isDense: true,
                              controller: passwordController,
                              hintText: AppText.password,
                              label: CommonMethods.appTexts(
                                context,
                                AppText.password,
                              ),
                              textInputType:
                              TextInputType.visiblePassword,
                              keyboardType: TextInputAction.done,
                              obscureText:
                              controller.obSecureText.value,
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
                                    return "Please enter a valid password";
                                  } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
                                      .hasMatch(val.trim())) {
                                    return "Password must contain capital,small letters and numbers";
                                  } else if (val.trim().length < 8) {
                                    return "Password must be more than 8 characters";
                                  } else if (passwordController
                                      .text !=
                                      confirmpasswordController
                                          .text) {
                                    return "Password are not the same";
                                  }
                                  return null;
                                }
                                return "Please enter a valid password";
                              },
                            ),
                      ),
                      CommonMethods.sizedBox(height: 30.h),
                      GetBuilder<SignUpController>(
                        init: SignUpController(),
                        builder: (controller) =>
                            AppTextFieldScreen(
                              isDense: true,
                              controller: confirmpasswordController,
                              hintText: 'Confirm Password',
                              label: CommonMethods.appTexts(
                                context,
                                'Confirm Password',
                              ),
                              textInputType:
                              TextInputType.visiblePassword,
                              keyboardType: TextInputAction.done,
                              obscureText:
                              controller.obSecureText.value,
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
                                    return "Please enter a valid password";
                                  } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
                                      .hasMatch(val.trim())) {
                                    return "Password must contain capital,small letters and numbers";
                                  } else if (val.trim().length < 8) {
                                    return "Password must be more than 8 characters";
                                  } else if (passwordController
                                      .text !=
                                      confirmpasswordController
                                          .text) {
                                    return "Password are not the same";
                                  }
                                  return null;
                                }
                                return "Please enter a valid password";
                              },
                            ),
                      ),
                      CommonMethods.sizedBox(height: 30.h),
                      isLoading
                          ? Container(
                          height: 54.h,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(64.r),
                            color: Themes.getPrimaryColor(
                                context),
                          ),
                          child: const Center(
                              child:
                              CircularProgressIndicator(
                                color: Colors.white,
                              )))
                          : GestureDetector(
                        onTap: () async {
                          if (updateFormKey.currentState!
                              .validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            var url = Uri.parse(
                                'https://www.sparkhub.ng/api/profile/bash');
                            // Your JSON data
                            var data = {
                              'password':
                              '${passwordController.text}',
                            };

                            // Convert the data to JSON format
                            var jsonData = jsonEncode(data);

                            // Set the headers
                            var headers = {
                              'Content-Type':
                              'application/json',
                              'Authorization':
                              'Bearer $access_token',
                            };

                            // Create an http.Client to handle redirects
                            var client = http.Client();

                            try {
                              var response =
                              await client.post(url,
                                  headers: headers,
                                  body: jsonData);

                              // Check for redirects manually
                              while (response.statusCode ==
                                  308 ||
                                  response.statusCode ==
                                      301 ||
                                  response.statusCode ==
                                      302) {
                                var redirectUrl = response
                                    .headers['location'];
                                if (redirectUrl != null) {
                                  url = Uri.parse(
                                      redirectUrl);
                                  response =
                                  await client.post(url,
                                      headers: headers,
                                      body: jsonData);
                                } else {
                                  print(
                                      'Error - Redirect location not found.');
                                  break;
                                }
                              }

                              // Check the final response status
                              if (response.statusCode ==
                                  200) {
                                // If the server returns a 200 OK response,
                                // parse the JSON response
                                Get.snackbar(
                                  'Success',
                                  'Password changed successfully, login to continue.',
                                  snackPosition:
                                  SnackPosition.TOP,
                                  colorText: Colors.white,
                                  backgroundColor:
                                  Colors.green,
                                  duration:
                                  Duration(seconds: 5),
                                );
                                CommonMethods
                                    .sendToNextScreen(
                                    context,
                                    RoutesPath
                                        .loginPage);
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
                                  snackPosition:
                                  SnackPosition.TOP,
                                  colorText: Colors.white,
                                  backgroundColor:
                                  Colors.red,
                                  duration:
                                  Duration(seconds: 2),
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
                              : AppText.login,
                        ),
                      ),
                      CommonMethods.sizedBox(height: 24.h),
                    ],
                  ),
                ),
              )
                  : Form(
                key: forgotFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),
                    CommonMethods.sizedBox(height: 16.h),
                    CommonMethods.appTexts(
                      context,
                      'Input the email address used when signing up for your account',
                      textAlign: TextAlign.center,
                      color: Themes.getTextColor(context),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    CommonMethods.sizedBox(height: 44.h),
                    Padding(
                      padding: CommonMethods.appPadding(),
                      child: Column(
                        children: [
                          AppTextFieldScreen(
                            isDense: true,
                            controller: emailController,
                            hintText: AppText.emailHint,
                            label: CommonMethods.appTexts(
                              context,
                              AppText.emailHint,
                            ),
                            textInputType:
                            TextInputType.emailAddress,
                            keyboardType: TextInputAction.done,
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                if (!RegExp(
                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                    .hasMatch(val)) {
                                  return "Please enter valid email";
                                }
                                return null;
                              }
                              return "Please enter email";
                            },
                          ),
                          CommonMethods.sizedBox(height: 30.h),
                          isLoading
                              ? Container(
                              height: 54.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                    64.r),
                                color:
                                Themes.getPrimaryColor(
                                    context),
                              ),
                              child: const Center(
                                  child:
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  )))
                              : GestureDetector(
                            onTap: () {
                              if (forgotFormKey
                                  .currentState!
                                  .validate()) {
                                postData(
                                    emailController.text);
                              }
                            },
                            child: const AppButton(
                              text: AppText.send,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          init: LogInController(),
        ));
  }

  void _sendPasswordResetEmail(String text) async {
    try {
      setState(() {
        isLoading = true;
      });
      await supabase.auth.resetPasswordForEmail('$text',
          redirectTo:
              'https://www.sparkhub.ng/api/auth/callback?next=onboarding/password/change');
      setState(() {
        isLoading = false;
        issend = true;
      });
      // final response =
      //     await Supabase.instance.client.auth.resetPasswordForEmail(
      //   _emailController.text.trim(),
      //       redirectTo: ''
      // );
      // if (response == null) {
      //   // Password reset email sent successfully
      //   print('Password reset email sent successfully');
      // } else {
      //   // Handle error
      //   // print('Error sending password reset email: ${response.}');
      // }
    } catch (error) {
      // Handle unexpected error
      print('Unexpected error: $error');
    }
  }

  Future<void> postData(String text) async {
    var url = Uri.parse('https://www.sparkhub.ng/api/auth/password/forgot');
    setState(() {
      isLoading = true;
    });
    // Your JSON data
    var data = {
      "email": "${emailController.text}",
      // "phone": "08108402170"
    };

    // Convert the data to JSON format
    var jsonData = jsonEncode(data);

    // Set the headers
    var headers = {'Content-Type': 'application/json'};

    // Create an http.Client to handle redirects
    var client = http.Client();

    try {
      var response = await client.post(url, headers: headers, body: jsonData);

      // Check for redirects manually
      while (response.statusCode == 308 ||
          response.statusCode == 301 ||
          response.statusCode == 302) {
        var redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          url = Uri.parse(redirectUrl);
          response = await client.post(url, headers: headers, body: jsonData);
        } else {
          print('Error - Redirect location not found.');
          break;
        }
      }

      // Check the final response status
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          isLoading = false;
          issend = true;
        });
        // Get.snackbar(
        //   'Success',
        //   'Reset link sent to email',
        //   snackPosition: SnackPosition.TOP,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.orange,
        //   duration: Duration(seconds: 1),
        // );
      } else {
        // If the server did not return a 200 OK response,
        // print the response status and body
        setState(() {
          isLoading = false;
        });
        print('Error - Status Code: ${response.statusCode}');
        print('Error - Body: ${response.body}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle any exceptions that may occur during the request
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
      // Close the client when done
      client.close();
    }
  }
}
