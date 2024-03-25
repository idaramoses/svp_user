import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';

class DetailRowCommon extends StatelessWidget {
  final String? type;
  final String? detail;
  const DetailRowCommon({super.key, this.type, this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonMethods.appTexts(
          context,
         type!,
          color: Themes.getHintTextColor(context),
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        Expanded(
          child: CommonMethods.appTexts(
            context,
            AppText.has,
            color: Themes.getTextColor(context),
            fontSize: 16.sp,
          ),
        ),
        CommonMethods.appTexts(
          context,
          detail!,
          color: Themes.getTextColor(context),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
