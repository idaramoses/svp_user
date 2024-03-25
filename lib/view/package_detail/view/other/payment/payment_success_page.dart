import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharkhub/res/common/app_methods.dart';
import 'package:sharkhub/res/constant/app_strings.dart';

import '../../../../../res/common/app_button.dart';
import '../../../../../res/constant/app_routes_path.dart';
import '../../../../../utils/themes.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return CommonMethods.sendToNextScreen(
            context, RoutesPath.bottomBarPage);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonMethods.imagesOfApp(
                  AppImages.paymentSuccess,
                  width: 154.h,
                  height: 154.h,
                ),
                CommonMethods.sizedBox(height: 30.h),
                CommonMethods.appTexts(
                  context,
                  AppText.paymentSuccess,
                  textAlign: TextAlign.center,
                  color: Themes.getTextColor(context),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
                CommonMethods.sizedBox(height: 8.h),
                CommonMethods.appTexts(
                  context,
                  AppText.congrates,
                  textAlign: TextAlign.center,
                  color: Themes.getTextColor(context),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                CommonMethods.sizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 89.w),
                  child: GestureDetector(
                    onTap: () {
                      CommonMethods.sendToNextScreen(
                          context, RoutesPath.bottomBarPage);
                    },
                    child: const AppButton(
                      text: AppText.goToHome,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
