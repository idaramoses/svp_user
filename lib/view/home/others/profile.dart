import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharkhub/view/notification/main/notification_page.dart';

import '../../../controller/main_wrapper_controller.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_strings.dart';

import '../../../utils/themes.dart';
import '../../profile/controller/profile_controller.dart';

class ProfileRow extends StatelessWidget {
  ProfileRow({super.key});
  final ProfileController profileController = Get.put(ProfileController());
  final MainWrapperController _mainWrapperController =
  Get.find<MainWrapperController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _mainWrapperController.isDarkTheme.value
          ? Colors.black
          : Colors.white,
      height: 85.h,
      child: Padding(
        padding: CommonMethods.appPadding(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonMethods.sizedBox(height: 16.h),
                    Obx(
                          () => CommonMethods.appTexts(
                        context,
                        'Hi, ${profileController.firstname} ${profileController.lastname}',
                        color: Themes.getTextColor(context),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        // style: TextStyle(
                        //   fontFamily: 'ProductSans',
                        // ),
                      ),
                    ),
                    CommonMethods.sizedBox(height: 5.h),
                    Obx(
                          () => CommonMethods.appTexts(
                        context,
                        '${profileController.location}',
                        color: Themes.getTextColor(context),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                  ],
                ),
              ],
            ),
            Row(
              children: [
                GetBuilder<MainWrapperController>(
                  builder: (controller) {
                    return Container(
                      child: Center(
                        child: IconButton(
                          icon: controller.isDarkTheme.value ? Icon(Icons.wb_sunny) : Icon(Icons.brightness_3),
                          onPressed: () {
                            controller.toggleTheme(); // Call the toggleTheme method to toggle the theme
                          },
                        ),
                      ),
                    );
                  },
                  init: MainWrapperController(), // Initialize the controller
                ),
                CommonMethods.sizedBox(width: 5.w),
                Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const NotificationPage());
                      },
                      child: Icon(
                        CupertinoIcons.bell,
                        color: Themes.getTextColor(context),
                      ),
                    ),
                  ),
                ),
                // CommonMethods.sizedBox(width: 8.w),
                // CommonMethods.imagesOfApp(
                //   AppImages.blankProfile,
                //   width: 45.h,
                //   height: 45.h,
                // ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
