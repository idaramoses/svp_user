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
import 'package:svp_admin_pm/widgets/custom_icon_button.dart';

import '../reports_list_one_screen/widgets/listbookmark_item_widget.dart';

class ReportsListOneScreen extends StatelessWidget {
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
                top: 25,
                right: 14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(
                      right: 11,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: getPadding(
                            top: 8,
                            bottom: 8,
                          ),
                          child: Text(
                            "ALL REPORTS",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextBold16,
                          ),
                        ),
                        CustomButton(
                          height: getVerticalSize(
                            37,
                          ),
                          width: getHorizontalSize(
                            108,
                          ),
                          text: "Upload",
                          variant: ButtonVariant.FillOrangeA200,
                          padding: ButtonPadding.PaddingT9,
                          fontStyle: ButtonFontStyle.SFProTextBold14,
                          suffixWidget: Container(
                            margin: getMargin(
                              left: 6,
                            ),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgUpload,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 25,
                      right: 30,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: getHorizontalSize(
                            80,
                          ),
                          decoration: AppDecoration.outlineGray3001.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                          ),
                          child: Row(
                            children: [
                              CustomIconButton(
                                height: 40,
                                width: 40,
                                child: CustomImageView(
                                  svgPath: ImageConstant.imgMenuWhiteA700,
                                ),
                              ),
                              CustomImageView(
                                svgPath: ImageConstant.imgGridOrangeA200,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                                margin: getMargin(
                                  left: 8,
                                  top: 8,
                                  bottom: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: getPadding(
                            top: 10,
                            bottom: 12,
                          ),
                          child: Text(
                            "Filter:",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextMedium14Gray500,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 45,
                            top: 12,
                            bottom: 10,
                          ),
                          child: Text(
                            "Sort by:",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextMedium14Gray500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 24,
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
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return ListbookmarkItemWidget();
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
