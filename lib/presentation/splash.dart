import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:svp_admin_pm/core/app_export.dart';

import '../core/utils/color_constant.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray200,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            CustomImageView(
              imagePath: ImageConstant.imgSvplogoprimary,
              height: getVerticalSize(
                80,
              ),
            ),
            SpinKitFadingCircle(
              color: ColorConstant.orangeA200,
            ),
          ],
        ),
      ),
    );
  }
}
