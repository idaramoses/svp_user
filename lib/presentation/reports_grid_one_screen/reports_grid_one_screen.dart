import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/dashboard_page/dashboard_page.dart';
import 'package:svp_admin_pm/presentation/messages_five_page/messages_five_page.dart';
import 'package:svp_admin_pm/presentation/projects_list_one_page/projects_list_one_page.dart';
import 'package:svp_admin_pm/presentation/reports_list_page/reports_list_page.dart';
import 'package:svp_admin_pm/presentation/tasks_list_tab_container_page/tasks_list_tab_container_page.dart';
import 'package:svp_admin_pm/widgets/custom_bottom_bar.dart';

import '../reports_grid_one_screen/widgets/gridbookmark_item_widget.dart';

class ReportsGridOneScreen extends StatelessWidget {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: getPadding(
                left: 16,
                top: 25,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(
                      top: 24,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: getVerticalSize(
                          186,
                        ),
                        crossAxisCount: 2,
                        mainAxisSpacing: getHorizontalSize(
                          12,
                        ),
                        crossAxisSpacing: getHorizontalSize(
                          12,
                        ),
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return GridbookmarkItemWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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
