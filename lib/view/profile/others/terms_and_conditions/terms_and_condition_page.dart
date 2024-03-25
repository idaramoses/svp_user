import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/common/app_methods.dart';
import '../../../../res/constant/app_strings.dart';
import '../../../../utils/themes.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({super.key});

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            CommonMethods.jumpOutFromScreen(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 16.h, top: 17.h, bottom: 20.h),
            child: CommonMethods.imagesOfApp(
              AppImages.arrowBack,
              width: 24.h,
              height: 24.h,

            ),
          ),
        ),
        backgroundColor: Themes.getScaffoldColor(context),
        title: CommonMethods.appTexts(
          context,
          AppText.termsAndConditions,
          color: Themes.getTextColor(context),
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Themes.getScaffoldColor(context),

        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: CommonMethods.appPadding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonMethods.sizedBox(height: 16.h),
              CommonMethods.appTexts(
                context,
                AppText.queOne,
                color: Themes.getTextColor(context),
                fontSize: 18.sp,
                height: 1.5,
                fontWeight: FontWeight.w700,
              ),
              CommonMethods.sizedBox(height: 8.h),
              Container(
                child: CommonMethods.appTexts(
                  context,
                  AppText.ansOne,
                  style: TextStyle(
                    wordSpacing: 2.8,
                    color: Themes.getTextColor(context),
                    fontSize: 16.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              CommonMethods.sizedBox(height: 16.h),
              CommonMethods.appTexts(
                context,
                AppText.queTwo,
                color: Themes.getTextColor(context),
                fontSize: 18.sp,
                height: 1.5,
                fontWeight: FontWeight.w700,
              ),
              CommonMethods.sizedBox(height: 8.h),
              Container(
                child:  CommonMethods.appTexts(
                  context,
                  AppText.ansTwo,
                  style: TextStyle(
                    wordSpacing: 2.8,
                    color: Themes.getTextColor(context),
                    fontSize: 16.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              CommonMethods.sizedBox(height: 16.h),
              CommonMethods.appTexts(
                context,
                AppText.queThree,
                color: Themes.getTextColor(context),
                fontSize: 18.sp,
                height: 1.5,
                fontWeight: FontWeight.w700,
              ),
              CommonMethods.sizedBox(height: 8.h),
              Container(
                child: CommonMethods.appTexts(
                  context,
                  AppText.ansThree,
                  style: TextStyle(
                    wordSpacing: 2.8,
                    color: Themes.getTextColor(context),
                    fontSize: 16.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
