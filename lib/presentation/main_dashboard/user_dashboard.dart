import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/dashboard_page/dashboard_page.dart';
import 'package:svp_admin_pm/presentation/messages_two_screen/messages_two_screen.dart';
import 'package:svp_admin_pm/presentation/projects_list_one_page/projects_list_one_page.dart';
import 'package:svp_admin_pm/presentation/reports_list_page/reports_list_page.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_style.dart';
import '../../utils/app_local_storage.dart';
import '../../widgets/app_bar/appbar_circleimage.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_image_view.dart';
import '../auth/signin/state/auth_provider.dart';
import '../tasks_list_tab_container_page/tasks_list_tab_container_page.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({Key key}) : super(key: key);

  @override
  _MainDashboardScreenState createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int pageIndex = 0;
  bool isInit = false;

  final pages = [
    DashboardPage(),
    ProjectsListOnePage(),
    TasksListTabContainerPage(),
    ReportsListPage(),
    MessagesTwoScreen()
  ];
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgDashboard,
      title: "Dashboard",
      type: BottomBarEnum.Dashboard2,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgComputerGray500,
      title: "Projects",
      type: BottomBarEnum.Projects,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgMenu,
      title: "Tasks",
      type: BottomBarEnum.Tasks2,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgMailGray500,
      title: "Reports",
      type: BottomBarEnum.Reports,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgMailGray50024x24,
      title: "Message",
      type: BottomBarEnum.Message,
    )
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      loadUserData(context);
      setState(() {
        isInit = true;
      });
    }
  }

  AppLocalStorage storage = AppLocalStorage();

  loadUserData(context) async {
    String token = await AppLocalStorage().fetch("token");
    Map<String, dynamic> _user = await AppLocalStorage().fetch("user");

    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    /// load user data to state
    authProvider.userInfo = _user;
    authProvider.token = token;
  }

  Future<bool> _willPopCallback() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (Platform.isIOS) {
        try {
          exit(0);
        } catch (e) {
          SystemNavigator
              .pop(); // for IOS, not true this, you can make comment this :)
        }
      } else {
        try {
          SystemNavigator.pop(); // sometimes it cant exit app
        } catch (e) {
          exit(0); // so i am giving crash to app ... sad :(
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: CustomAppBar(
          height: getVerticalSize(
            70,
          ),
          leadingWidth: 80,
          leading: AppbarImage(
            height: getVerticalSize(
              32,
            ),
            width: getHorizontalSize(
              64,
            ),
            imagePath: ImageConstant.imgSvppnglogo1,
            margin: getMargin(
              left: 16,
              // top: 56,
              // bottom: 12,
            ),
          ),
          actions: [
            AppbarImage(
              height: getSize(
                24,
              ),
              width: getSize(
                24,
              ),
              svgPath: ImageConstant.imgSearch,
              margin: getMargin(
                left: 16,
                top: 10,
                right: 12,
                bottom: 4,
              ),
            ),
            Container(
              height: getSize(
                24,
              ),
              width: getSize(
                24,
              ),
              margin: getMargin(
                left: 22,
                top: 25,
                right: 12,
                bottom: 4,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  AppbarImage(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.notificationsOneScreen);
                    },
                    height: getSize(
                      30,
                    ),
                    width: getSize(
                      50,
                    ),
                    svgPath: ImageConstant.imgNotification,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: getSize(
                        8,
                      ),
                      width: getSize(
                        8,
                      ),
                      margin: getMargin(
                        left: 16,
                        bottom: 16,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.red500,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppbarCircleimage(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.profileScreen);
              },
              imagePath: ImageConstant.imgEllipse12,
              margin: getMargin(
                left: 22,
                top: 8,
                right: 28,
              ),
            ),
          ],
          styleType: Style.bgOutlineGray300,
        ),
        body: pages[pageIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: ColorConstant.gray200,
            border: Border(
              top: BorderSide(
                color: ColorConstant.gray300,
                width: getHorizontalSize(
                  1,
                ),
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            currentIndex: pageIndex,
            type: BottomNavigationBarType.fixed,
            items: List.generate(bottomMenuList.length, (index) {
              return BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImageView(
                      svgPath: bottomMenuList[index].icon,
                      height: getSize(
                        24,
                      ),
                      width: getSize(
                        24,
                      ),
                      color: ColorConstant.gray500,
                    ),
                    Padding(
                      padding: getPadding(
                        top: 5,
                      ),
                      child: Text(
                        bottomMenuList[index].title ?? "",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtInterMedium12Gray500.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.06,
                          ),
                          color: ColorConstant.gray500,
                        ),
                      ),
                    ),
                  ],
                ),
                activeIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImageView(
                      svgPath: bottomMenuList[index].icon,
                      height: getSize(
                        24,
                      ),
                      width: getSize(
                        24,
                      ),
                      color: ColorConstant.orangeA200,
                    ),
                    Padding(
                      padding: getPadding(
                        top: 4,
                      ),
                      child: Text(
                        bottomMenuList[index].title ?? "",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtInterBold12Lime700.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.06,
                          ),
                          color: ColorConstant.lime700,
                        ),
                      ),
                    ),
                  ],
                ),
                label: '',
              );
            }),
            onTap: (index) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.work_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.work_outline_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.widgets_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.widgets_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}
