import 'dart:async';

import 'package:get/get.dart';

import '../../../data/pref_data.dart';
import '../../../res/constant/app_routes_path.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     checkData();
  }

  checkData() async {
    bool isIntro = await PrefData.getIntro();
    bool isLogin = await PrefData.getLogin();

    Timer(const Duration(seconds: 3), () {
      if (isLogin) {
        Get.toNamed(RoutesPath.onBoardingPage);
      } else {
        // Get.off(PinCodeScreen());

        Get.toNamed(RoutesPath.pinValidatePage);
      }
    });
  }
}
