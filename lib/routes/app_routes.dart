import 'package:flutter/material.dart';
import 'package:svp_admin_pm/presentation/dashboard_container_screen/dashboard_container_screen.dart';
import 'package:svp_admin_pm/presentation/dashboard_one_screen/dashboard_one_screen.dart';
import 'package:svp_admin_pm/presentation/messages_four_screen/messages_four_screen.dart';
import 'package:svp_admin_pm/presentation/messages_one_screen/messages_one_screen.dart';
import 'package:svp_admin_pm/presentation/messages_screen/messages_screen.dart';
import 'package:svp_admin_pm/presentation/messages_three_screen/messages_three_screen.dart';
import 'package:svp_admin_pm/presentation/messages_two_screen/messages_two_screen.dart';
import 'package:svp_admin_pm/presentation/new_project_form_one_screen/new_project_form_one_screen.dart';
import 'package:svp_admin_pm/presentation/new_project_form_screen/new_project_form_screen.dart';
import 'package:svp_admin_pm/presentation/notifications_one_screen/notifications_one_screen.dart';
import 'package:svp_admin_pm/presentation/notifications_screen/notifications_screen.dart';
import 'package:svp_admin_pm/presentation/projects_grid_one_screen/projects_grid_one_screen.dart';
import 'package:svp_admin_pm/presentation/projects_grid_screen/projects_grid_screen.dart';
import 'package:svp_admin_pm/presentation/projects_list_screen/projects_list_screen.dart';
import 'package:svp_admin_pm/presentation/projects_one_screen/projects_one_screen.dart';
import 'package:svp_admin_pm/presentation/projects_screen/projects_screen.dart';
import 'package:svp_admin_pm/presentation/reports_grid_one_screen/reports_grid_one_screen.dart';
import 'package:svp_admin_pm/presentation/reports_grid_screen/reports_grid_screen.dart';
import 'package:svp_admin_pm/presentation/reports_list_one_screen/reports_list_one_screen.dart';
import 'package:svp_admin_pm/presentation/tasks_one_screen/tasks_one_screen.dart';
import 'package:svp_admin_pm/presentation/tasks_screen/tasks_screen.dart';
import 'package:svp_admin_pm/presentation/upload_reports_one_screen/upload_reports_one_screen.dart';
import 'package:svp_admin_pm/presentation/upload_reports_screen/upload_reports_screen.dart';

import '../presentation/auth/signin/signin.dart';
import '../presentation/auth/signup/signup.dart';
import '../presentation/main_dashboard/user_dashboard.dart';
import '../presentation/profile_screen/profile.dart';

class AppRoutes {
  static const String uploadReportsScreen = '/upload_reports_screen';

  static const String projectsOneScreen = '/projects_one_screen';

  static const String tasksScreen = '/tasks_screen';

  static const String dashboardPage = '/dashboard_page';

  static const String dashboardContainerScreen = '/dashboard_container_screen';

  static const String projectsListOnePage = '/projects_list_one_page';

  static const String tasksListPage = '/tasks_list_page';

  static const String tasksListTabContainerPage =
      '/tasks_list_tab_container_page';

  static const String reportsListPage = '/reports_list_page';

  static const String maindashboardOneScreen = '/maindashboardOneScreen';

  static const String messagesFivePage = '/messages_five_page';

  static const String messagesScreen = '/messages_screen';

  static const String messagesOneScreen = '/messages_one_screen';

  static const String reportsGridOneScreen = '/reports_grid_one_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String projectsGridScreen = '/projects_grid_screen';

  static const String tasksGridPage = '/tasks_grid_page';

  static const String tasksCalendarPage = '/tasks_calendar_page';

  static const String tasksCalendarTwoPage = '/tasks_calendar_two_page';

  static const String uploadReportsOneScreen = '/upload_reports_one_screen';

  static const String projectsScreen = '/projects_screen';

  static const String tasksOneScreen = '/tasks_one_screen';

  static const String dashboardOneScreen = '/dashboard_one_screen';

  static const String newProjectFormOneScreen = '/new_project_form_one_screen';

  static const String projectsListScreen = '/projects_list_screen';

  static const String tasksListOnePage = '/tasks_list_one_page';

  static const String reportsListOneScreen = '/reports_list_one_screen';

  static const String messagesTwoScreen = '/messages_two_screen';

  static const String messagesFourScreen = '/messages_four_screen';

  static const String messagesThreeScreen = '/messages_three_screen';

  static const String newProjectFormScreen = '/new_project_form_screen';

  static const String reportsGridScreen = '/reports_grid_screen';

  static const String notificationsOneScreen = '/notifications_one_screen';

  static const String projectsGridOneScreen = '/projects_grid_one_screen';

  static const String tasksGridOnePage = '/tasks_grid_one_page';

  static const String tasksCalendarOnePage = '/tasks_calendar_one_page';

  static const String tasksCalendarThreePage = '/tasks_calendar_three_page';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String signupScreen = '/signup_screen';

  static const String signinScreen = '/signin_screen';

  static const String profileScreen = '/profile_screen';

  static Map<String, WidgetBuilder> routes = {
    signupScreen: (context) => signup(),
    signinScreen: (context) => signin(),
    profileScreen: (context) => Profile_Screen(),
    uploadReportsScreen: (context) => UploadReportsScreen(),
    projectsOneScreen: (context) => ProjectsOneScreen(),
    tasksScreen: (context) => TasksScreen(),
    dashboardContainerScreen: (context) => DashboardContainerScreen(),
    messagesScreen: (context) => MessagesScreen(),
    messagesOneScreen: (context) => MessagesOneScreen(),
    reportsGridOneScreen: (context) => ReportsGridOneScreen(),
    notificationsScreen: (context) => NotificationsScreen(),
    projectsGridScreen: (context) => ProjectsGridScreen(),
    uploadReportsOneScreen: (context) => UploadReportsOneScreen(),
    projectsScreen: (context) => ProjectsScreen(),
    tasksOneScreen: (context) => TasksOneScreen(),
    dashboardOneScreen: (context) => DashboardOneScreen(),
    maindashboardOneScreen: (context) => MainDashboardScreen(),
    newProjectFormOneScreen: (context) => NewProjectFormOneScreen(),
    projectsListScreen: (context) => ProjectsListScreen(),
    reportsListOneScreen: (context) => ReportsListOneScreen(),
    messagesTwoScreen: (context) => MessagesTwoScreen(),
    messagesFourScreen: (context) => MessagesFourScreen(),
    messagesThreeScreen: (context) => MessagesThreeScreen(),
    newProjectFormScreen: (context) => NewProjectFormScreen(),
    reportsGridScreen: (context) => ReportsGridScreen(),
    notificationsOneScreen: (context) => NotificationsOneScreen(),
    projectsGridOneScreen: (context) => ProjectsGridOneScreen(),
  };
}
