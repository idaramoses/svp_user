import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/themes.dart';
import '../constant/app_strings.dart';
import 'app_methods.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonMethods.sizedBox(height: 10.h),
        CommonMethods.appBar(
          title: CommonMethods.appTexts(
            context,
            AppText.forgotPass,
            color: Themes.getTextColor(context),
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        CommonMethods.sizedBox(height: 10.h),
        Divider(
          color: Themes.getDividerColor(context),
        ),
      ],
    );
  }
}
