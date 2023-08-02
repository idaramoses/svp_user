import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/auth/signin/state/auth_provider.dart';
import 'package:svp_admin_pm/presentation/main_dashboard/user_dashboard.dart';
import 'package:svp_admin_pm/presentation/messages_screen/state/messages_provider.dart';
import 'package:svp_admin_pm/presentation/notifications_one_screen/state/notification_provider.dart';
import 'package:svp_admin_pm/presentation/onboarding_page/onboarding_screen.dart';
import 'package:svp_admin_pm/presentation/profile_screen/state/profile_provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_provider.dart';
import 'package:svp_admin_pm/presentation/reports_page/state/report_provider.dart';
import 'package:svp_admin_pm/presentation/splash.dart';
import 'package:svp_admin_pm/presentation/tasks_page_main/state/task_provider.dart';
import 'package:svp_admin_pm/routes/app_routes.dart';
import 'package:svp_admin_pm/utils/app_local_storage.dart';

import 'models/main_user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppLocalStorage storage = AppLocalStorage();
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     theme: ThemeData(
  //       visualDensity: VisualDensity.standard,
  //     ),
  //     title: 'svp_admin_pm',
  //     debugShowCheckedModeBanner: false,
  //     initialRoute: AppRoutes.signupScreen,
  //     routes: AppRoutes.routes,
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ProjectProvider()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => ProfileProvider()),
            ChangeNotifierProvider(create: (_) => TaskProvider()),
            ChangeNotifierProvider(create: (_) => ReportProvider()),
            ChangeNotifierProvider(create: (_) => NotificationProvider()),
            ChangeNotifierProvider(create: (_) => MessagesProvider()),
          ],
          child: MaterialApp(
            home: FutureBuilder(
              future: fetchAuthData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data["token"] != null) {
                    if (checkAuthenticated(snapshot.data)) {
                      return MainDashboardScreen(id: 0);
                    }
                  }
                  return OnboardingScreen();
                } else {
                  return FutureBuilder(
                    future: Future.delayed(Duration(seconds: 7)),
                    builder: (context, snapshot) {
                      return SplashScreen();
                    },
                  );
                }
              },
            ),
            title: "SVP",
            theme: ThemeData(
              visualDensity: VisualDensity.standard,
            ),
            routes: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }

  bool checkAuthenticated(data) {
    if (data["token"] != null &&
        data["token"] != "" &&
        data["user"] != null &&
        data["user"] != "") return true;

    return false;
  }

  Future<Map<String, dynamic>> fetchAuthData() async {
    String token = await storage.fetch("token");
    Map<String, dynamic> _user = await storage.fetch("user");
    User user = (_user != null) ? User.fromJson({..._user}) : User();

    return {
      "token": token,
      "user": user,
    };
  }
}
