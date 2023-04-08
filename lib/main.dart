import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/models/main_user.dart';
import 'package:svp_admin_pm/presentation/auth/signin/signin.dart';
import 'package:svp_admin_pm/presentation/auth/signin/state/auth_provider.dart';
import 'package:svp_admin_pm/presentation/main_dashboard/user_dashboard.dart';
import 'package:svp_admin_pm/presentation/profile_screen/state/profile_provider.dart';
import 'package:svp_admin_pm/presentation/splash.dart';
import 'package:svp_admin_pm/presentation/tasks_list_tab_container_page/state/task_provider.dart';
import 'package:svp_admin_pm/routes/app_routes.dart';
import 'package:svp_admin_pm/utils/app_local_storage.dart';
import 'package:svp_admin_pm/utils/flushbar_mixin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget with FlushBarMixin {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => TasksProvider()),
      ],
      child: MaterialApp(
        home: FutureBuilder(
          future: fetchAuthData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data["token"] != null) {
                if (checkAuthenticated(snapshot.data)) {
                  return MainDashboardScreen();
                }
              }
              return signin();
            } else {
              return FutureBuilder(
                future: Future.delayed(Duration(seconds: 10)),
                builder: (context, snapshot) {
                  return SplashScreen();
                },
              );
            }
          },
        ),
        title: "Alumates",
        theme: ThemeData(
          visualDensity: VisualDensity.standard,
        ),
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
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
