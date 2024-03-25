import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/common/app_button.dart';
import '../../../../res/common/app_methods.dart';
import '../../../../res/common/app_textfield.dart';
import '../../../../res/constant/app_routes_path.dart';
import '../../../../res/constant/app_strings.dart';
import '../../../../utils/themes.dart';
import '../../controller/login_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  LogInController logInController = Get.find();
  final resetFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonMethods.appBar(
        onTap: () {
          CommonMethods.jumpOutFromScreen(context);
        },
        title: CommonMethods.appTexts(
          context,
          AppText.resetPass,
          color: Themes.getTextColor(context),
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(
              color: Themes.getDividerColor(context),
            ),
            CommonMethods.sizedBox(height: 16.h),
            CommonMethods.appTexts(
              context,
              AppText.forgotDes,
              textAlign: TextAlign.center,
              color: Themes.getTextColor(context),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            CommonMethods.sizedBox(height: 36.h),
            Padding(
              padding: CommonMethods.appPadding(),
              child: Form(
                key: resetFormKey,
                child: Column(
                  children: [
                    GetBuilder<LogInController>(
                      init: LogInController(),
                      builder: (controller) => AppTextFieldScreen(
                        isDense: true,
                        controller: controller.newPasswordController,
                        hintText: AppText.newPass,
                        label: CommonMethods.appTexts(
                          context,
                          AppText.newPass,
                        ),
                        textInputType: TextInputType.visiblePassword,
                        keyboardType: TextInputAction.next,
                        obscureText: controller.newObSecureText,
                        maxLines: 1,
                        onChanged: (val) {
                          logInController.passwordCreate.value = val;
                          if (logInController
                              .passwordCreate.value.isEmpty) {
                            logInController.passwordFieldColor.value =
                            true;
                          } else {
                            logInController.passwordFieldColor.value =
                            false;
                          }
                          logInController.update();
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.newObSecureText =
                            !controller.newObSecureText;
                            logInController.update();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.h),
                            child: CommonMethods.imagesOfApp(
                              controller.newObSecureText
                                  ? AppImages.eyeClose
                                  : AppImages.eye,

                              height: 24.h,
                              width: 24.h,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.trim().isNotEmpty) {
                            if (val.trim().isEmpty) {
                              return "Enter valid password";
                            }
                            return null;
                          }
                          return "Enter password";
                        },
                      ),
                    ),
                    CommonMethods.sizedBox(height: 24.h),
                    GetBuilder<LogInController>(
                      init: LogInController(),
                      builder: (controller) => AppTextFieldScreen(
                        isDense: true,
                        controller: controller.confirmPasswordController,
                        hintText: AppText.confirmPass,
                        label: CommonMethods.appTexts(
                          context,
                          AppText.confirmPass,
                        ),
                        textInputType: TextInputType.visiblePassword,
                        keyboardType: TextInputAction.done,
                        obscureText: controller.reEnterPass,
                        maxLines: 1,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.reEnterPass =
                            !controller.reEnterPass;
                            logInController.update();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.h),
                            child: CommonMethods.imagesOfApp(
                              controller.reEnterPass
                                  ? AppImages.eyeClose
                                  : AppImages.eye,

                              height: 24.h,
                              width: 24.h,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.trim().isNotEmpty) {
                            logInController.reenterPassword.value = val;
                            logInController.update();
                            if (logInController.reenterPassword.value ==
                                logInController.passwordCreate.value) {
                              return null;
                            } else {
                              return "Please check password";
                            }
                          }
                          return "Enter password";
                        },
                      ),
                    ),
                    CommonMethods.sizedBox(height: 50.h),
                    GestureDetector(
                      onTap: () {
                        if (resetFormKey.currentState!.validate()) {
                          CommonMethods.sendToNextScreen(
                              context, RoutesPath.passSuccessPage);
                        }
                      },
                      child: const AppButton(
                        text: AppText.resetPass,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
