import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:sharkhub/utils/themes.dart';
import 'package:sharkhub/view/electricity/view/bottom_electricity_bill_page.dart';
import 'package:sharkhub/view/home/main/home_page.dart';
import 'package:sharkhub/view/profile/main/profile_page.dart';
import 'package:sharkhub/view/transaction/main/transaction_page.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'controller/main_wrapper_controller.dart';
import 'utils/color_constants.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _mainWrapperController.onExit();
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          notchMargin: 10,
          child: Container(
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBarItem(
                    icon: IconlyLight.home,
                    page: 0,
                    context,
                    label: "Home",
                  ),
                  _bottomAppBarItem(
                      icon: Icons.lightbulb_outline,
                      page: 1,
                      context,
                      label: "Buy"),
                  _bottomAppBarItem(
                      icon: IconlyLight.chart,
                      page: 2,
                      context,
                      label: "History"),
                  _bottomAppBarItem(
                      icon: IconlyLight.profile,
                      page: 3,
                      context,
                      label: "Profile"),
                ],
              ),
            ),
          ),
        ),
        body: Obx(() {
          switch (_mainWrapperController.currentPage.value) {
            case 0:
              return HomePage();
            case 1:
              return BottomElectricityBillPage();
            case 2:
              return TransactionPage();
            case 3:
              return ProfilePage();
            default:
              return Container(); // Or any default widget
          }
        }),
      ),
    );
  }
  Widget _getPage(int page) {
    switch (page) {
      case 0:
        return HomePage();
      case 1:
        return BottomElectricityBillPage();
      case 2:
        return TransactionPage();
      case 3:
        return ProfilePage();
      default:
        return Container(); // Return a default empty container if the page is not found
    }
  }
  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => _mainWrapperController.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _mainWrapperController.currentPage == page
                  ? Themes.getPrimaryColor(context)
                  : Themes.getTextColor(context),
              size: 20,
            ),
            SizedBox(height: 7,),
            Text(
              label,
              style: TextStyle(
                  color: _mainWrapperController.currentPage == page
                      ? Themes.getPrimaryColor(context)
                      :  Themes.getTextColor(context),
                  fontSize: 13,
                  fontWeight: _mainWrapperController.currentPage == page
                      ? FontWeight.w600
                      : null),
            ),
          ],
        ),
      ),
    );
  }
}
