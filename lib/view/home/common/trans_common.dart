import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/common/app_methods.dart';
import '../../../utils/themes.dart';

class TransactionsCommon extends StatelessWidget {
  final String? image;
  final String? title;
  final String? price;
  final String? des;
  final Color? color;
  const TransactionsCommon({
    super.key,
    this.image,
    this.title,
    this.price,
    this.color,
    this.des,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: CommonMethods.getBoxDecoration(
        cornerRadius: 12.r,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 16.w),
        child: Row(
          children: [
            Container(
                height: 48.h,
                width: 48.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: CommonMethods.imagesOfApp(image!,
                      height: 48.h, width: 48.h),
                )),
            CommonMethods.sizedBox(width: 16.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonMethods.appTexts(
                    context,
                    title!,
                    color: Themes.getTextColor(context),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  CommonMethods.sizedBox(height: 10.h),
                  CommonMethods.appTexts(
                    context,
                    des!,
                    color: Themes.getTextColor(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            CommonMethods.appTexts(
              context,
              'N${price!}',
              color: Themes.getTextColor(context),
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
