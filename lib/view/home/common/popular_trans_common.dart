import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';

class PopularTransCommon extends StatelessWidget {
  final String? image;
  final String? title;
  final String? status;
  final String? price;
  const PopularTransCommon({
    super.key,
    this.image,
    this.title,
    this.status,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonMethods.sendToNextScreen(context, RoutesPath.transactionDetailPage);
      },
      child: Stack(
        children: [
          CommonMethods.imagesOfApp(
            image!,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w, top: 75.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonMethods.appTexts(
                  context,
                  title!,
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                CommonMethods.sizedBox(height: 16.h),
                CommonMethods.appTexts(
                  context,
                  status!,
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
                CommonMethods.sizedBox(height: 8.h),
                CommonMethods.appTexts(
                  context,
                  price!,
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
