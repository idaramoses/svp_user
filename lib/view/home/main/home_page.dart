import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharkhub/res/common/app_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharkhub/view/home/controller/home_controller.dart';

import '../../../controller/main_wrapper_controller.dart';
import '../../../utils/themes.dart';
import '../others/categories.dart';
import '../others/offers.dart';
import '../others/profile.dart';
import '../others/recent_trans.dart';
import '../others/welcome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  final MainWrapperController _mainWrapperController =
  Get.find<MainWrapperController>();

  final HomeController _homeController =
  Get.find<HomeController>();
  @override
  void initState() {
    super.initState();

    // print("App start from background----------------------");
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.fetchrecentData();
      print("Resume data");
    });
    print("Resume");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
     super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Perform actions when app resumes from background
      print("App resumed from background----------------------");
    }
    if (state == AppLifecycleState.paused) {
      // Perform actions when app resumes from background
      print("App paused from background---------------------");
    }
  }


  Future<void> checkGenderAndShowDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? gender = prefs.getString('meter');

    if (gender == null || gender == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return WelcomeDialog();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _mainWrapperController.isDarkTheme.value
          ? Colors.black
          : Colors.white,
      appBar: CommonMethods.nullAppBar(
        context,
        statusBarColor:
        _mainWrapperController.isDarkTheme.value
            ? Colors.black
            : Colors.white,

      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: _mainWrapperController.isDarkTheme.value
                  ? Colors.black
                  : Colors.white,

              pinned: true,
              expandedHeight: 85.h,
              collapsedHeight: 85.h,
              leading: Container(),
              flexibleSpace: FlexibleSpaceBar(
                title: ProfileRow(),
                collapseMode: CollapseMode.none,

                titlePadding: EdgeInsets.only(left: 5, top: 5),
                centerTitle: false,
                expandedTitleScale: 1.13,
              ),
            ),
            // Add other slivers or widgets here
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Column(
                    children: [
                      const OffersList(),
                      const Categories(),
                      // PopularTransaction(),
                      RecentTransaction(),
                    ],
                  );
                },
                childCount: 1, // Adjust this based on your needs
              ),
            ),
          ],
        ),
      ),
    );
  }
}
