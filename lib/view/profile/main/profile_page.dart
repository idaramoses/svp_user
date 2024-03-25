import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharkhub/view/electricity/controller/electricity_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../controller/main_wrapper_controller.dart';
import '../../../data/pref_data.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../res/constant/app_strings.dart';

import '../../../utils/themes.dart';
import '../common/profile_common.dart';
import '../controller/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController profileController = Get.put(ProfileController());
  final ElectricityController electricityController =
      Get.put(ElectricityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.getScaffoldColor(context),
        leadingWidth: 200.w,
        leading: Padding(
          padding: CommonMethods.appPadding(),
          child: CommonMethods.appTexts(
            context,
            AppText.profile,
            color: Themes.getTextColor(context),
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(
              color: Themes.getDividerColor(context),
            ),
            CommonMethods.sizedBox(height: 10.h),
            Padding(
              padding: CommonMethods.appPadding(),
              child: Column(
                children: [
                  CommonMethods.imagesOfApp(
                    AppImages.blankProfile,
                    width: 140.h,
                    height: 104.h,
                  ),
                  CommonMethods.sizedBox(height: 8.h),
                  Obx(
                        () => CommonMethods.appTexts(
                      context,
                      '${profileController.firstname} ${profileController.lastname}',
                      color: Themes.getTextColor(context),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                        () => CommonMethods.appTexts(
                      context,
                      '${profileController.email}',
                      color: Themes.getTextColor(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CommonMethods.sizedBox(height: 24.h),
                  ProfileCommon(
                    title: AppText.personalInfo,
                    image: AppImages.unselectUser,
                    onTap: () {
                      CommonMethods.sendToNextScreen(
                          context, RoutesPath.myProfilePage);
                    },
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                  Container(
                    height: 54.h,
                    decoration: CommonMethods.getBoxDecoration(
                      cornerRadius: 20.r,
                      color: Themes.getCardColor(context),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 17.71.w,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.light_mode_outlined,
                            color: Themes.getTextColor(context),
                            size: 20,
                          ),
                          CommonMethods.sizedBox(width: 12.w),
                          Expanded(
                            child: CommonMethods.appTexts(
                              context,
                              AppText.theme,
                              color: Themes.getTextColor(context),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GetBuilder(
                            builder: (controller) {
                              return SizedBox(
                                height: 20.h,
                                width: 36.w,
                                child:  Obx(
                                      () => Switch(
                                        value: controller.isDarkTheme.value,
                                        onChanged: (value) {
                                          controller.toggleTheme(); // Call the toggleTheme method to toggle the theme
                                        },
                                        activeColor: Themes.getPrimaryColor(context), // Customize the color when the switch is on (dark mode)
                                        inactiveThumbColor: Themes.getPrimaryColor(context), // // Customize the color when the switch is off (light mode)
                                      ),

                                )
                              );
                            },
                            init: MainWrapperController(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  CommonMethods.sizedBox(height: 16.h),

                  ProfileCommon(
                    title: AppText.logout,
                    image: AppImages.loggingOut,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            contentPadding: EdgeInsets.zero,
                            content: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30.h, horizontal: 26.w),
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
                                            CommonMethods.jumpOutFromScreen(
                                                context);
                                          },
                                          child: Container(
                                            height: 46.h,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40.w),
                                            decoration: CommonMethods
                                                .getBoxDecoration(
                                              color:
                                              Themes.getScaffoldColor(
                                                  context),
                                              cornerRadius: 8.r,
                                              borderColor:
                                              Themes.getPrimaryColor(
                                                  context),
                                            ),
                                            child: Center(
                                              child: CommonMethods.appTexts(
                                                context,
                                                AppText.cancel,
                                                color: Themes
                                                    .getPrimaryColor(
                                                    context),
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
                                            await Supabase
                                                .instance.client.auth
                                                .signOut();
                                            profileController.clearText();
                                            electricityController
                                                .clearText();
                                            CommonMethods.sendToNextScreen(
                                                context,
                                                RoutesPath.loginPage);
                                          },
                                          child: Container(
                                            height: 46.h,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40.w),
                                            decoration: CommonMethods
                                                .getBoxDecoration(
                                              color:
                                              Themes.getPrimaryColor(
                                                  context),
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
                        },
                      );
                    },
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
