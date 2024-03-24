import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/common/app_methods.dart';
import '../../../utils/themes.dart';

class MyProfileCommon extends StatelessWidget {
  final String? title;
  final String? info;
  const MyProfileCommon({super.key, this.title, this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73.h,
      width: double.infinity,
      decoration: CommonMethods.getBoxDecoration(
        color: Themes.getCardColor(context),
        cornerRadius: 20.r,
      ),
      child: Padding(
        padding: CommonMethods.appPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonMethods.appTexts(
              context,
              title!,
              color: const Color(0xFF808080),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            CommonMethods.sizedBox(height: 6.h),
            CommonMethods.appTexts(
              context,
              info!,
              color: Themes.getTextColor(context),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
