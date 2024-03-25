import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/themes.dart';
import 'app_methods.dart';

class AppButton extends StatelessWidget {
  final String? text;
  const AppButton({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(64.r),
        color: Themes.getPrimaryColor(context),
      ),
      child: Center(
        child: CommonMethods.appTexts(
          context,
          text!,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
        ),
      )
    );
  }
}
