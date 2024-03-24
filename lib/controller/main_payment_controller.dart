import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/electricity/view/bottom_electricity_bill_page.dart';
import '../view/home/main/home_page.dart';
import '../view/profile/main/profile_page.dart';

import '../view/transaction/main/transaction_page.dart';



class MainPaymnentController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 0.obs;
  RxBool isDarkTheme = false.obs;

  List<Widget> pages = [
    const HomePage(),
    const BottomElectricityBillPage(),
    const TransactionPage(),
    const ProfilePage(),
  ];
  RxInt selectedIndex = 0.obs;
  List<Widget> screenList = <Widget>[];

  getData() {
    screenList = <Widget>[
      const HomePage(),
      // const BottomElectricityBillPage(),
      const TransactionPage(),
      const ProfilePage(),
    ];
    selectedIndex.value = 1;
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    update();
  }

  onExit() {
    if (selectedIndex.value != 0) {
      selectedIndex.value = 0;
      update();
    } else {
      if (Platform.isIOS) {
        exit(0);
      } else {
        SystemNavigator.pop();
      }
    }
  }
  ThemeMode get theme => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  // Future<void> loadThemeFromPrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   isDarkTheme.value = prefs.getBool('isDarkTheme') ?? false;
  //   Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
  // }
  Future<void> loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkTheme.value = prefs.getBool('isDarkTheme') ?? true; // Change to true
    Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }
  Future<void> toggleTheme() async {
    isDarkTheme.value = !isDarkTheme.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme.value);
    Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }
  void switchTheme(ThemeMode mode) {
    Get.changeThemeMode(mode);
  }

  void goToTab(int page) {
    currentPage.value = page;
    // pageController.jumpToPage(page);
  }
  void animateToTab(int page) {
    currentPage.value = page;
   // pageController.animateToPage(page,
   //            duration: const Duration(milliseconds: 300),
   //            curve: Curves.ease);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    loadThemeFromPrefs(); // Load theme preference when controller initializes
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
