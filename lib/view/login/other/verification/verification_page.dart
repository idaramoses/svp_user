import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sharkhub/view/login/controller/login_controller.dart';
import '../../../../res/common/app_button.dart';
import '../../../../res/common/app_methods.dart';
import '../../../../res/constant/app_routes_path.dart';
import '../../../../res/constant/app_strings.dart';
import '../../../../utils/themes.dart';

class VerificationPage extends StatefulWidget {
  final String? emailAddress;
  const VerificationPage({super.key,  this.emailAddress});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  LogInController logInController = Get.put(LogInController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonMethods.appBar(
        onTap: () {
          CommonMethods.jumpOutFromScreen(context);
        },
        title: CommonMethods.appTexts(
          context,
          AppText.verification,
          color: Themes.getTextColor(context),
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: logInController.pinForm,
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
              RichText(
                text: TextSpan(
                  text: AppText.sendTo,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SF Pro Display',
                    color: Themes.getTextColor(context),
                  ),
                  children: [
                    TextSpan(
                      text: AppText.mail,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint('SUCCESS======');
                        },
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w600,
                        color: Themes.getTextColor(context),
                      ),
                    ),
                  ],
                ),
              ),
              CommonMethods.sizedBox(height: 16.h),
              Padding(
                padding: CommonMethods.appPadding(),
                child: Column(
                  children: [
                    Pinput(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      controller: logInController.pinController,
                      length: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid code";
                        }
                        return null;
                      },
                      errorPinTheme: PinTheme(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        width: 50.h,
                        height: 50.h,
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        width: 50.h,
                        height: 50.h,
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Themes.getDividerColor(context)),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                    CommonMethods.sizedBox(height: 30.h),
                    GestureDetector(
                      onTap: () {
                        if (logInController.pinForm.currentState!.validate()) {
                          CommonMethods.sendToNextScreen(
                              context, RoutesPath.resetPasswordPage);
                        }
                      },
                      child: const AppButton(
                        text: AppText.send,
                      ),
                    ),
                  ],
                ),
              ),
              CommonMethods.sizedBox(height: 30.h),
              RichText(
                text: TextSpan(
                  text: AppText.notReceive,
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
                          debugPrint('Resend======');
                        },
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w600,
                        color: Themes.getPrimaryColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
