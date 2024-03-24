import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharkhub/res/common/app_button.dart';
import 'package:sharkhub/res/common/app_methods.dart';
import 'package:sharkhub/res/constant/app_strings.dart';

import '../../../../res/constant/app_routes_path.dart';
import '../../../../utils/themes.dart';

class PassSuccessPage extends StatefulWidget {
  const PassSuccessPage({super.key});

  @override
  State<PassSuccessPage> createState() => _PassSuccessPageState();
}

class _PassSuccessPageState extends State<PassSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonMethods.imagesOfApp(
              AppImages.success,
              height: 154.h,
              width: 154.h,
            ),
            CommonMethods.sizedBox(height: 30.h),
            CommonMethods.appTexts(
              context,
              AppText.passSuccess,
              textAlign: TextAlign.center,
              color: Themes.getTextColor(context),
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
            CommonMethods.sizedBox(height: 5.h),
            CommonMethods.appTexts(
              context,
              AppText.passDes,
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
                  CommonMethods.sendToNextScreen(context, RoutesPath.loginPage);
                },
                child: const AppButton(
                  text: AppText.goToLogin,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
