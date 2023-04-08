import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/dashboard_page/dashboard_page.dart';
import 'package:svp_admin_pm/presentation/messages_five_page/messages_five_page.dart';
import 'package:svp_admin_pm/presentation/projects_list_one_page/projects_list_one_page.dart';
import 'package:svp_admin_pm/presentation/reports_list_page/reports_list_page.dart';
import 'package:svp_admin_pm/presentation/tasks_list_tab_container_page/tasks_list_tab_container_page.dart';
import 'package:svp_admin_pm/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class DashboardContainerScreen extends StatelessWidget {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray200,
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.dashboardPage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar:
                CustomBottomBar(onChanged: (BottomBarEnum type) {
              Navigator.pushNamed(
                  navigatorKey.currentContext, getCurrentRoute(type));
            })));
  }

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

  @override
  void onInit(BuildContext context) {}
}
