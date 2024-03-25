import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/common/app_methods.dart';
import '../../../../res/constant/app_routes_path.dart';
import '../../../../res/constant/app_strings.dart';
import '../../../../utils/themes.dart';
import '../../common/myprofile_common.dart';
import '../../controller/profile_controller.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final ProfileController profileController = Get.put(ProfileController());

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
            AppText.myProfile,
            color: Themes.getTextColor(context),
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                CommonMethods.sendToNextScreen(
                    context, RoutesPath.editProfilePage);
              },
              child: Padding(
                padding: EdgeInsets.all(14.h),
                child: CommonMethods.imagesOfApp(
                  AppImages.edit,
                  width: 24.h,
                  height: 24.h,
                  color: Themes.getTextColor(context),
                ),
              ),
            )
          ]),
      body: SafeArea(
        child: Column(
          children: [
            Divider(
              color: Themes.getDividerColor(context),
            ),
            CommonMethods.sizedBox(height: 10.h),
            Center(
              child: Container(
                height: 104.h,
                width: 104.h,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    CommonMethods.imagesOfApp(
                      AppImages.blankProfile,
                      height: 104.h,
                      width: 104.h,
                    ),
                  ],
                ),
              ),
            ),
            CommonMethods.sizedBox(height: 34.h),
            Padding(
              padding: CommonMethods.appPadding(),
              child: Column(
                children: [
                  Obx(
                        () => MyProfileCommon(
                      title: 'First name',
                      info: '${profileController.firstname}',
                    ),
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                  Obx(
                        () => MyProfileCommon(
                      title: 'Last name',
                      info: '${profileController.lastname}',
                    ),
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                  Obx(
                        () => MyProfileCommon(
                      title: AppText.email,
                      info: '${profileController.email} ',
                    ),
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                  Obx(
                        () => MyProfileCommon(
                      title: 'Meter number',
                      info: '${profileController.meter} ',
                    ),
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                  Obx(
                        () => MyProfileCommon(
                      title: 'Location',
                      info: '${profileController.location} ',
                    ),
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                  Obx(
                        () => MyProfileCommon(
                      title: AppText.phone,
                      info: '${profileController.phone} ',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
