import 'package:flutter/material.dart';
import 'package:svp_admin_pm/presentation/messages_screen/messages_screen.dart';
import 'package:svp_admin_pm/presentation/new_project_form_one_screen/new_project_form_one_screen.dart';
import 'package:svp_admin_pm/presentation/new_project_form_screen/new_project_form_screen.dart';
import 'package:svp_admin_pm/presentation/reports_page/upload_reports_screen.dart';
import '../presentation/auth/signin/signin.dart';
import '../presentation/auth/signup/signup.dart';
import '../presentation/main_dashboard/user_dashboard.dart';
import '../presentation/messages_screen/Messages_screen.dart';
import '../presentation/notifications_one_screen/Notification_screen.dart';
import '../presentation/onboarding_page/onboarding_screen.dart';
import '../presentation/onboarding_page/waitlist/waitlist.dart';
import '../presentation/onboarding_page/welcome.dart';
import '../presentation/profile_screen/profile.dart';
import '../presentation/projects_main/project_grid_screen.dart';
import '../presentation/projects_main/projects_details_screen/projects_details_screen.dart';
import '../presentation/projects_main/projects_main.dart';
import '../presentation/reports_page/reports_grid_one_screen/reports_grid_one_screen.dart';
import '../presentation/reports_page/reports_page.dart';

class AppRoutes {
  static const String uploadReportsScreen = '/upload_reports_screen';

  static const String projectdetails = '/projects_one_screen';

  static const String tasksScreen = '/tasks_screen';

  static const String dashboardPage = '/dashboard_page';

  static const String dashboardContainerScreen = '/dashboard_container_screen';

  static const String projectsListOnePage = '/projects_list_one_page';

  static const String tasksListPage = '/tasks_list_page';

  static const String tasksListTabContainerPage = '/tasks_page';

  static const String reportsListPage = '/reports_page';

  static const String maindashboardOneScreen = '/maindashboardOneScreen';

  static const String messagesFivePage = '/messages_five_page';

  static const String messagesScreen = '/messages_screen';

  static const String messagesOneScreen = '/messages_one_screen';

  static const String reportsGridOneScreen = '/reports_grid_one_screen';

  static const String notificationsScreen = '/profile_screen';

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

  static const String onboardScreen = '/onboard_screen';

  static const String welcomeScreen = '/welcome_screen';

  static const String waitlistScreen = '/waitlist_screen';

  // static const String messageFiveScreen = '/message_five_screen';

  static Map<String, WidgetBuilder> routes = {
    welcomeScreen: (context) => WelcomeScreen(),
    notificationsOneScreen: (context) =>  NotificationsOneScreen(),
    waitlistScreen: (context) => Waitlist(),
    onboardScreen: (context) => OnboardingScreen(),
    signupScreen: (context) => signup(),
    signinScreen: (context) => signin(),
    profileScreen: (context) => Profile_Screen(),
    uploadReportsScreen: (context) => UploadReportsScreen(),
    projectdetails: (context) => ProjectsDetailsScreen(),
    reportsGridOneScreen: (context) => ReportGridScreen(),
    projectsGridScreen: (context) => ProjectGridScreen(),
    projectsScreen: (context) => ProjectsMainPage(),
    maindashboardOneScreen: (context) => MainDashboardScreen(),
    newProjectFormOneScreen: (context) => NewProjectFormOneScreen(),
    reportsListOneScreen: (context) => ReportPage(),
    newProjectFormScreen: (context) => NewProjectFormScreen(),
  };
}
