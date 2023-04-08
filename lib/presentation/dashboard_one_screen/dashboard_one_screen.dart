import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/dashboard_page/dashboard_page.dart';
import 'package:svp_admin_pm/presentation/messages_five_page/messages_five_page.dart';
import 'package:svp_admin_pm/presentation/projects_list_one_page/projects_list_one_page.dart';
import 'package:svp_admin_pm/presentation/reports_list_page/reports_list_page.dart';
import 'package:svp_admin_pm/presentation/tasks_list_tab_container_page/tasks_list_tab_container_page.dart';
import 'package:svp_admin_pm/widgets/app_bar/appbar_circleimage.dart';
import 'package:svp_admin_pm/widgets/app_bar/appbar_image.dart';
import 'package:svp_admin_pm/widgets/app_bar/custom_app_bar.dart';
import 'package:svp_admin_pm/widgets/custom_bottom_bar.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_drop_down.dart';

import '../dashboard_one_screen/widgets/dashboard_one1_item_widget.dart';
import '../dashboard_one_screen/widgets/dashboard_one_item_widget.dart';

class DashboardOneScreen extends StatelessWidget {
  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
        appBar: CustomAppBar(
          height: getVerticalSize(
            100,
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
              top: 56,
              bottom: 12,
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
                top: 60,
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
                left: 32,
                top: 60,
                right: 12,
                bottom: 4,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  AppbarImage(
                    height: getSize(
                      24,
                    ),
                    width: getSize(
                      24,
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
              imagePath: ImageConstant.imgEllipse12,
              margin: getMargin(
                left: 32,
                top: 56,
                right: 28,
              ),
            ),
          ],
          styleType: Style.bgOutlineGray300,
        ),
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: getPadding(
                left: 16,
                top: 23,
                right: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(
                      right: 1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "DASHBOARD",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextBold16,
                            ),
                            Padding(
                              padding: getPadding(
                                top: 7,
                              ),
                              child: Text(
                                "Hello John!",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextSemibold14,
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          height: getVerticalSize(
                            37,
                          ),
                          width: getHorizontalSize(
                            175,
                          ),
                          text: "Add New Project",
                          margin: getMargin(
                            top: 4,
                            bottom: 2,
                          ),
                          variant: ButtonVariant.FillOrangeA200,
                          padding: ButtonPadding.PaddingT9,
                          fontStyle: ButtonFontStyle.SFProTextBold14,
                          suffixWidget: Container(
                            margin: getMargin(
                              left: 6,
                            ),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgPlusWhiteA700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 24,
                      right: 1,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: getVerticalSize(
                          181,
                        ),
                        crossAxisCount: 2,
                        mainAxisSpacing: getHorizontalSize(
                          8,
                        ),
                        crossAxisSpacing: getHorizontalSize(
                          8,
                        ),
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return DashboardOneItemWidget();
                      },
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: getPadding(
                            top: 3,
                          ),
                          child: Text(
                            "In Progress",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextBold16,
                          ),
                        ),
                        CustomDropDown(
                          width: getHorizontalSize(
                            80,
                          ),
                          focusNode: FocusNode(),
                          icon: Container(
                            margin: getMargin(
                              left: 5,
                            ),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgArrowdownOrangeA200,
                            ),
                          ),
                          hintText: "View all",
                          variant: DropDownVariant.None,
                          padding: DropDownPadding.PaddingT2,
                          fontStyle:
                              DropDownFontStyle.SFProTextSemibold14OrangeA200,
                          items: dropdownItemList,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 16,
                      right: 1,
                    ),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: getVerticalSize(
                            16,
                          ),
                        );
                      },
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return DashboardOne1ItemWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {
            Navigator.pushNamed(
                navigatorKey.currentContext, getCurrentRoute(type));
          },
        ),
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Dashboard2:
        return AppRoutes.dashboardPage;
      case BottomBarEnum.Projects:
        return AppRoutes.projectsListOnePage;
      case BottomBarEnum.Tasks2:
        return AppRoutes.tasksListTabContainerPage;
      case BottomBarEnum.Reports:
        return AppRoutes.reportsListPage;
      case BottomBarEnum.Message:
        return AppRoutes.messagesFivePage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.dashboardPage:
        return DashboardPage();
      case AppRoutes.projectsListOnePage:
        return ProjectsListOnePage();
      case AppRoutes.tasksListTabContainerPage:
        return TasksListTabContainerPage();
      case AppRoutes.reportsListPage:
        return ReportsListPage();
      case AppRoutes.messagesFivePage:
        return MessagesFivePage();
      default:
        return DefaultWidget();
    }
  }
}
