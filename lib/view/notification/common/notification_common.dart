import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';

class NotificationCommon extends StatelessWidget {
  final String? title;
  final String? time;
  const NotificationCommon({
    super.key,
    this.title,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.h,
      decoration: CommonMethods.getBoxDecoration(
        color: Themes.getCardColor(context),
        cornerRadius: 16.r,
      ),
      child: Padding(
        padding: CommonMethods.appPadding(),
        child: Row(
          children: [
            Container(
              height: 44.h,
              width: 44.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0x14000000),
                      offset: Offset(0, 1),
                      blurRadius: 17,
                      spreadRadius: 0)
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: CommonMethods.imagesOfApp(AppImages.selectNotification),
              ),
            ),
            CommonMethods.sizedBox(width: 14.w),
            Expanded(
              child: CommonMethods.appTexts(
                context,
               title!,
                color: Themes.getTextColor(context),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CommonMethods.appTexts(
                  context,
                  time!,
                  color: const Color(0xFF808080),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
