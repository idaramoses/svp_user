import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../res/common/app_button.dart';
import '../../../../../res/common/app_methods.dart';
import '../../../../../res/constant/app_routes_path.dart';
import '../../../../../res/constant/app_strings.dart';
import '../../../../../utils/themes.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonMethods.appBar(
        onTap: () {
          CommonMethods.jumpOutFromScreen(context);
        },
        backgroundColor: Themes.getScaffoldColor(context),
        title: CommonMethods.appTexts(
          context,
          AppText.amountToPay,
          color: Themes.getTextColor(context),
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(
              color: Themes.getDividerColor(context),
            ),
            CommonMethods.sizedBox(height: 30.h),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFFFDCDE)),
                    child: Center(
                      child: CommonMethods.imagesOfApp(
                        AppImages.viCard,
                        height: 48.h,
                        width: 60.08.h,
                      ),
                    ),
                  ),
                  CommonMethods.sizedBox(height: 24.h),
                  CommonMethods.appTexts(
                    context,
                    AppText.ronald,
                    textAlign: TextAlign.center,
                    color: Themes.getTextColor(context),
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  CommonMethods.sizedBox(height: 8.h),
                  CommonMethods.appTexts(
                    context,
                    AppText.prepaid,
                    textAlign: TextAlign.center,
                    color: Themes.getTextColor(context),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CommonMethods.sizedBox(height: 40.h),
                  Container(
                    height: 77.h,
                    margin: CommonMethods.appPadding(),
                    decoration: CommonMethods.getBoxDecoration(
                      cornerRadius: 12.r,
                      color: Themes.getCardColor(context),
                    ),
                    child: Padding(
                      padding: CommonMethods.appPadding(),
                      child: Row(
                        children: [
                          CommonMethods.imagesOfApp(
                            AppImages.axisBank,
                            width: 54.h,
                            height: 54.h,
                          ),
                          CommonMethods.sizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonMethods.appTexts(
                                  context,
                                  AppText.axis,
                                  color: Themes.getTextColor(context),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                CommonMethods.sizedBox(height: 8.h),
                                CommonMethods.appTexts(
                                  context,
                                  AppText.axisMail,
                                  color: Themes.getTextColor(context),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          CommonMethods.imagesOfApp(
                            AppImages.nextArrow,
                            width: 24.h,
                            height: 24.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommonMethods.sizedBox(height: 69.h),
                  CommonMethods.appTexts(
                    context,
                    AppText.thirdPrice,
                    textAlign: TextAlign.center,
                    color: Themes.getTextColor(context),
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  CommonMethods.sizedBox(height: 40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 104.w),
                    child: TextField(
                      showCursor: false,
                      style: TextStyle(
                        color: Themes.getTextColor(context),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: Themes.getCardColor(context),
                        hintText: AppText.typeMsg,
                        hintStyle: TextStyle(
                          color: Themes.getTextColor(context),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        prefixIcon: SizedBox(width: 52.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: CommonMethods.appPadding(),
              child: GestureDetector(
                onTap: () {
                  CommonMethods.sendToNextScreen(
                      context, RoutesPath.paymentSuccessPage);
                },
                child: const AppButton(
                  text: AppText.payNow,
                ),
              ),
            ),
            CommonMethods.sizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
