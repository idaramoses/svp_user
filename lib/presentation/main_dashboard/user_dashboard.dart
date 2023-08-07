import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/dashboard_page/dashboard_page.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../utils/app_local_storage.dart';
import '../../widgets/app_bar/appbar_circleimage.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_image_view.dart';
import '../auth/signin/sign_in_controller.dart';
import '../auth/signin/state/auth_provider.dart';
import '../messages_screen/Messages_screen.dart';
import '../projects_main/projects_main.dart';
import '../reports_page/reports_page.dart';
import '../tasks_page_main/tasks_page.dart';

class MainDashboardScreen extends StatefulWidget {
  int id;
  MainDashboardScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _MainDashboardScreenState createState() => _MainDashboardScreenState(id: id);
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int id;
  var pageIndex = 0;
  bool isInit = false;
  _MainDashboardScreenState({
    this.id,
  });
  final pages = [
    DashboardPage(),
    ProjectsMainPage(),
    TasksPage(),
    ReportPage(),
    MessagesScreen()
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
  Future<void> didChangeDependencies() async {
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

  Future<void> _showMyDialog() async {
    Map<String, dynamic> credentials = {};
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to delete your account?'),
                Text('It wil be deleted permanently.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                SignInController(context: context).delete(credentials);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Consumer<AuthProvider>(
          builder: (context, value, child) => SafeArea(
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
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * .7,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    height: getVerticalSize(
                                      70,
                                    ),
                                    width: double.maxFinite,
                                    child: Container(
                                      width: double.maxFinite,
                                      padding: getPadding(
                                        // all: 16,
                                        bottom: 8,
                                        left: 10,
                                        right: 16,
                                      ),
                                      decoration: AppDecoration.outlineGray300,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  icon: Icon(
                                                    Icons.arrow_back,
                                                    color: ColorConstant
                                                        .orangeA200,
                                                  )),
                                              Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgEllipse12,
                                    height: getSize(
                                      72,
                                    ),
                                    width: getSize(
                                      72,
                                    ),
                                    radius: BorderRadius.circular(
                                      getHorizontalSize(
                                        36,
                                      ),
                                    ),
                                    margin: getMargin(
                                      top: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      top: 7,
                                    ),
                                    child: Text(
                                      value.userInfo.firstName ?? '...',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextBold12Gray500,
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      top: 7,
                                    ),
                                    child: Text(
                                      value.userInfo.lastName ?? '...',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextBold12Gray500,
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      top: 4,
                                    ),
                                    child: Text(
                                      value.userInfo.email ?? '...',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextRegular14,
                                    ),
                                  ),
                                  Container(
                                    margin: getMargin(
                                      left: 16,
                                      top: 24,
                                      right: 16,
                                    ),
                                    padding: getPadding(
                                      left: 15,
                                      top: 10,
                                      right: 15,
                                      bottom: 10,
                                    ),
                                    decoration: AppDecoration.outlineGray3005,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                            top: 1,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "02",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtSFProTextSemibold18Gray800,
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  top: 9,
                                                ),
                                                child: Text(
                                                  "In progress",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtInterRegular16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            top: 1,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "05",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtSFProTextSemibold18Gray800,
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  top: 9,
                                                ),
                                                child: Text(
                                                  "Completed",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtInterRegular16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            top: 1,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "01",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtSFProTextSemibold18Gray800,
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  top: 9,
                                                ),
                                                child: Text(
                                                  "Upcoming",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtInterRegular16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: getHorizontalSize(150),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  onTap: () async {
                                                    SignInController(
                                                            context: context)
                                                        .signOut()
                                                        .whenComplete(() {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              AppRoutes
                                                                  .onboardScreen);
                                                    });
                                                  },
                                                  leading: CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgArrowright,
                                                  ),
                                                  title: Text(
                                                    "Log out",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        AppStyle.txtInterBold16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ListTile(
                                    onTap: () async {
                                      _showMyDialog();
                                    },
                                    tileColor: Colors.red,
                                    leading: Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "Delete",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
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
              body: pages[id == 0 ? pageIndex : id],
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
                  currentIndex: id == 0 ? pageIndex : id,
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
                      id = index;
                      pageIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ));
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
