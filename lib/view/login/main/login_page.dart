import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharkhub/res/constant/app_strings.dart';
import 'package:sharkhub/view/login/controller/login_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/pref_data.dart';
import '../../../data/service_api.dart';
import '../../../main.dart';
import '../../../model/user_model.dart';
import '../../../res/common/app_button.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/common/app_textfield.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../utils/themes.dart';
import '../../profile/controller/profile_controller.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  LogInController logInController = Get.put(LogInController());
  final ProfileController _profileController = Get.find();
  final SuperbaseService _superbaseService = SuperbaseService();
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CommonMethods.nullAppBar(
          context,
          statusBarColor: Themes.getScaffoldColor(context),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 40.h, left: 16.h, right: 16.h),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CommonMethods.sizedBox(height: 38.h),
                              CommonMethods.appTexts(
                                context,
                                AppText.login,
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
                                controller: logInController.emailController,
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
                                      return "Please enter a valid email address";
                                    }
                                    return null;
                                  }
                                  return "Please enter a valid email address";
                                },
                              ),
                              CommonMethods.sizedBox(height: 24.h),
                              GetBuilder<LogInController>(
                                init: LogInController(),
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
                                        return "Please enter a valid password";
                                      } else if (!RegExp(
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
                                          .hasMatch(val.trim())) {
                                        return "Password must contain capital,small letters and numbers";
                                      }
                                      return null;
                                    }
                                    return "Please enter a valid password";
                                  },
                                ),
                              ),
                              CommonMethods.sizedBox(height: 16.h),
                              GestureDetector(
                                onTap: () {
                                  CommonMethods.sendToNextScreen(
                                      context, RoutesPath.forgotPassPage);
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CommonMethods.appTexts(
                                    context,
                                    'Forgot password?',
                                    color: Themes.getTextColor(context),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              CommonMethods.sizedBox(height: 30.h),
                              GestureDetector(
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      final result = await Supabase
                                          .instance.client.auth
                                          .signInWithPassword(
                                        email: logInController
                                            .emailController.text,
                                        password: logInController
                                            .passwordController.text,
                                      );
                                      User? user = Supabase
                                          .instance.client.auth.currentUser;
                                      // Now you can access user data like user.id, user.email, etc.
                                      // For example:
                                      String? accessToken =
                                          result?.session?.accessToken;
                                      Map<String, dynamic>? metadata =
                                          user?.userMetadata;
                                      final userModel =
                                          UserModel.fromJson(metadata!);
                                      final SharedPreferences prefs =
                                          await _prefs;
                                      await prefs?.setString(
                                          'token', '$accessToken');
                                      await prefs?.setString('location',
                                          '${metadata['location']}');
                                      await prefs?.setString(
                                          'email', '${user?.email}');
                                      await prefs?.setString('firstname',
                                          '${metadata['firstname']}');
                                      await prefs?.setString('lastname',
                                          '${metadata['lastname']}');
                                      await prefs?.setString(
                                          'id', '${user?.id}');
                                      await prefs?.setString(
                                          'phone', '${metadata['phone']}');
                                      final isEmailExist = await supabase
                                          .from('welcome_pin')
                                          .select()
                                          .eq('user_id', '${user?.id}')
                                          .limit(1)
                                          .maybeSingle();
                                      if (isEmailExist == null) {
                                      } else {
                                        var mainresponse = await supabase
                                            .from('welcome_pin')
                                            .select()
                                            .eq('user_id', '${user?.id}')
                                            .single();
                                        await prefs?.setString('pincode',
                                            '${mainresponse['pin']}');
                                        await prefs?.setString(
                                            'welcome', 'yes');
                                      }

                                      // Save user data to SharedPreferences
                                      await _superbaseService
                                          .saveUserDataToLocalStorage(
                                              userModel);
                                      // Set user data for the profile screen
                                      _profileController.setUserDetails(
                                        userModel.id,
                                        userModel.firstname,
                                        userModel.lastname,
                                        userModel.email,
                                        userModel.phone,
                                        userModel.location,
                                        userModel.meter,
                                        userModel.accessToken,
                                      );
                                      logInController.clearText();
                                      PrefData.setLogin(false);
                                      Get.toNamed(RoutesPath.pinValidatePage);
                                      // Sign-in successful, navigate to the next screen
                                    } catch (e) {
                                      // Handle sign-in failure
                                      print("Error signing in: $e");
                                      // Check if the error message indicates an invalid email
                                      if (e.toString().contains(
                                          'Invalid login credentials')) {
                                        Get.snackbar(
                                          'Error',
                                          'Invalid login credentials',
                                          snackPosition: SnackPosition.TOP,
                                          colorText: Colors.white,
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        );
                                      }

                                      // Show error message to the user
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                child: AppButton(
                                  text: isLoading
                                      ? 'Logging in...'
                                      : AppText.login,
                                ),
                              ),
                              CommonMethods.sizedBox(height: 30.h),
                              // GestureDetector(
                              //   onTap: () async {
                              //     final result =
                              //     await supabase.auth.signInWithOAuth(
                              //       Provider.google,
                              //       redirectTo: kIsWeb
                              //           ? null
                              //           : 'io.supabase.flutter://callback',
                              //     );
                              //     setState(() {
                              //       isLoading = true;
                              //     });
                              //     supabase.auth.onAuthStateChange
                              //         .listen((data) async {
                              //       final AuthChangeEvent event =
                              //           data.event;
                              //       if (event == AuthChangeEvent.signedIn) {
                              //         User? user = Supabase
                              //             .instance.client.auth.currentUser;
                              //         // Now you can access user data like user.id, user.email, etc.
                              //         // For example:
                              //         Map<String, dynamic>? metadata =
                              //             user?.userMetadata;
                              //         final userModel =
                              //         UserModel.fromJson(metadata!);
                              //         final SharedPreferences prefs =
                              //         await _prefs;
                              //         // await prefs?.setString(
                              //         //     'token', '$accessToken');
                              //         await prefs?.setString('location',
                              //             '${metadata['location']}');
                              //         await prefs?.setString(
                              //             'email', '${user?.email}');
                              //         await prefs?.setString('firstname',
                              //             '${metadata['firstname']}');
                              //         await prefs?.setString('lastname',
                              //             '${metadata['lastname']}');
                              //         await prefs?.setString(
                              //             'id', '${user?.id}');
                              //         await prefs?.setString(
                              //             'phone', '${metadata['phone']}');
                              //         await prefs?.setString(
                              //             'meter', '${metadata['meter']}');
                              //         final isEmailExist = await supabase
                              //             .from('welcome_pin')
                              //             .select()
                              //             .eq('user_id', '${user?.id}')
                              //             .limit(1)
                              //             .maybeSingle();
                              //         if (isEmailExist == null) {
                              //         } else {
                              //           var mainresponse = await supabase
                              //               .from('welcome_pin')
                              //               .select()
                              //               .eq('user_id', '${user?.id}')
                              //               .single();
                              //           await prefs?.setString('pincode',
                              //               '${mainresponse['pin']}');
                              //           await prefs?.setString(
                              //               'welcome', 'yes');
                              //         }
                              //
                              //         // Save user data to SharedPreferences
                              //         await _superbaseService
                              //             .saveUserDataToLocalStorage(
                              //             userModel);
                              //         // Set user data for the profile screen
                              //         _profileController.setUserDetails(
                              //           userModel.id,
                              //           userModel.firstname,
                              //           userModel.lastname,
                              //           userModel.email,
                              //           userModel.phone,
                              //           userModel.location,
                              //           userModel.meter,
                              //           userModel.accessToken,
                              //         );
                              //
                              //         setState(() {
                              //           isLoading = false;
                              //         });
                              //
                              //         if (user == null) {
                              //           throw 'No user is currently signed in.';
                              //         }
                              //
                              //         // Get the user metadata
                              //         final userMetadata =
                              //             user.userMetadata;
                              //
                              //         // Check if the 'firstname' field exists in the metadata
                              //         final hasFirstName = metadata !=
                              //             null &&
                              //             metadata.containsKey('firstname');
                              //
                              //         // Print the result
                              //         if (hasFirstName) {
                              //           print(
                              //               'The user has a firstname: ${metadata!['firstname']}');
                              //           Get.toNamed(
                              //               RoutesPath.pinValidatePage);
                              //         } else {
                              //           print(
                              //               'The user does not have a firstname.');
                              //           Get.toNamed(
                              //               RoutesPath.updateProfilePage);
                              //         }
                              //       }
                              //     });
                              //   },
                              //   child: Container(
                              //     height: 54.h,
                              //     decoration:
                              //     CommonMethods.getBoxDecoration(
                              //       cornerRadius: 30.r,
                              //       color: Themes.getCardColor(context),
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //       MainAxisAlignment.center,
                              //       children: [
                              //         CommonMethods.imagesOfApp(
                              //           AppImages.google,
                              //           height: 24.h,
                              //           width: 24.h,
                              //         ),
                              //         CommonMethods.sizedBox(width: 16.w),
                              //         CommonMethods.appTexts(
                              //           context,
                              //           AppText.google,
                              //           color:
                              //           Themes.getTextColor(context),
                              //           fontSize: 18.sp,
                              //           fontWeight: FontWeight.w600,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // Column(
                              //   children: [
                              //     CommonMethods.sizedBox(height: 16.h),
                              //     CommonMethods.appTexts(
                              //       context,
                              //       AppText.or,
                              //       color: Themes.getTextColor(context),
                              //       fontSize: 18.sp,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //     CommonMethods.sizedBox(height: 16.h),
                              //     // Row(
                              //     //   children: [
                              //     //     Container(
                              //     //       height: 54.h,
                              //     //       width: 190.w,
                              //     //       decoration: CommonMethods.getBoxDecoration(
                              //     //         cornerRadius: 30.r,
                              //     //         color: Themes.getCardColor(context),
                              //     //       ),
                              //     //       child: Row(
                              //     //         mainAxisAlignment:
                              //     //             MainAxisAlignment.center,
                              //     //         children: [
                              //     //           CommonMethods.imagesOfApp(
                              //     //             AppImages.google,
                              //     //             height: 24.h,
                              //     //             width: 24.h,
                              //     //           ),
                              //     //           CommonMethods.sizedBox(width: 16.w),
                              //     //           CommonMethods.appTexts(
                              //     //             context,
                              //     //             AppText.google,
                              //     //             color: Themes.getTextColor(context),
                              //     //             fontSize: 18.sp,
                              //     //             fontWeight: FontWeight.w600,
                              //     //           ),
                              //     //         ],
                              //     //       ),
                              //     //     ),
                              //     //     // CommonMethods.sizedBox(width: 16.w),
                              //     //     // Container(
                              //     //     //   height: 54.h,
                              //     //     //   width: 190.w,
                              //     //     //   decoration: CommonMethods.getBoxDecoration(
                              //     //     //     cornerRadius: 30.r,
                              //     //     //     color: Themes.getCardColor(context),
                              //     //     //   ),
                              //     //     //   child: Row(
                              //     //     //     mainAxisAlignment:
                              //     //     //         MainAxisAlignment.center,
                              //     //     //     children: [
                              //     //     //       CommonMethods.imagesOfApp(
                              //     //     //         AppImages.apple,
                              //     //     //         height: 24.h,
                              //     //     //         width: 24.h,
                              //     //     //       ),
                              //     //     //       CommonMethods.sizedBox(width: 16.w),
                              //     //     //       CommonMethods.appTexts(
                              //     //     //         context,
                              //     //     //         AppText.apple,
                              //     //     //         color: Themes.getTextColor(context),
                              //     //     //         fontSize: 18.sp,
                              //     //     //         fontWeight: FontWeight.w600,
                              //     //     //       ),
                              //     //     //     ],
                              //     //     //   ),
                              //     //     // ),
                              //     //   ],
                              //     // ),
                              //   ],
                              // ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: AppText.account,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'SF Pro Display',
                                  color: Themes.getTextColor(context),
                                ),
                                children: [
                                  TextSpan(
                                    text: AppText.signup,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        debugPrint('SUCCESS======');
                                        CommonMethods.sendToNextScreen(
                                            context, RoutesPath.signupPage);
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
                    ],
                  ),
                ),
              ),
              isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
