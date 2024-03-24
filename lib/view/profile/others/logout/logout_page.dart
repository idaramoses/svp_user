import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/pref_data.dart';
import '../../../../res/common/app_methods.dart';
import '../../../../res/constant/app_routes_path.dart';
import '../../../../res/constant/app_strings.dart';
import '../../../../utils/themes.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 26.w),
        decoration: CommonMethods.getBoxDecoration(
          color: Themes.getScaffoldColor(context),
          cornerRadius: 16.r,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonMethods.appTexts(
              context,
              AppText.logoutDes,
              textAlign: TextAlign.center,
              color: Themes.getTextColor(context),
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            CommonMethods.sizedBox(height: 30.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      CommonMethods.jumpOutFromScreen(context);
                    },
                    child: Container(
                      height: 46.h,
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      decoration: CommonMethods.getBoxDecoration(
                        color: Themes.getScaffoldColor(context),
                        cornerRadius: 8.r,
                        borderColor: Themes.getPrimaryColor(context),
                      ),
                      child: Center(
                        child: CommonMethods.appTexts(
                          context,
                          AppText.cancel,
                          color: Themes.getPrimaryColor(context),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                CommonMethods.sizedBox(width: 18.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      PrefData.cleardate();
                      PrefData.setLogin(true);
                      CommonMethods.sendToNextScreen(
                          context, RoutesPath.loginPage);
                    },
                    child: Container(
                      height: 46.h,
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      decoration: CommonMethods.getBoxDecoration(
                        color: Themes.getPrimaryColor(context),
                        cornerRadius: 8.r,
                      ),
                      child: Center(
                        child: CommonMethods.appTexts(
                          context,
                          AppText.logout,
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
