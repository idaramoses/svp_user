import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sharkhub/res/common/app_methods.dart';
import 'package:sharkhub/res/constant/app_strings.dart';

import '../../utils/themes.dart';
import 'controller/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.getPrimaryColor(context),
      appBar: CommonMethods.nullAppBar(
        context,
        statusBarColor: Themes.getPrimaryColor(context),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(),
          Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Center(
                      child: CommonMethods.imagesOfApp(
                        AppImages.splashLogo,
                        height: 300.h,


                      ),
                    ),
                    CommonMethods.sizedBox(height: 11.h),
                  ],
                ),
              ],
            ),
          ),
          SpinKitThreeBounce(
            color: Colors.white,
            size: 23.h,
          ),
        ],
      ),
    );
  }
}
