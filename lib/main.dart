import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharkhub/controller/main_payment_controller.dart';
import 'package:sharkhub/main_payment.dart';
import 'package:sharkhub/res/constant/app_routes_path.dart';
import 'package:sharkhub/view/electricity/controller/electricity_controller.dart';
import 'package:sharkhub/view/electricity/controller/readmeter_controller.dart';
import 'package:sharkhub/view/home/controller/home_controller.dart';

import 'package:sharkhub/view/profile/controller/profile_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controller/main_wrapper_controller.dart';
import '../main_wrapper.dart';
import '../utils/themes.dart';
import 'data/service_api.dart';



Future<void> main() async {
  await Supabase.initialize(
    url: 'https://wdzndcahywimomsjpdcd.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indkem5kY2FoeXdpbW9tc2pwZGNkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4ODQxNjcsImV4cCI6MjAyMDQ2MDE2N30.MYJDyO4mH9nLrCPm_qKKKv721sUS7US794Y27h_5egY',
    // authCallbackUrlHostname: 'login-callback', // optional
  );
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
}
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: Get.put(MainWrapperController()).theme,
          routes: RoutesPath.routes,
          initialBinding: BindingsBuilder(() {
            Get.put(SuperbaseService());
            Get.put(ProfileController());
            Get.put(MainWrapperController());
            Get.put(MainPaymnentController());
            Get.put(HomeController());
            Get.put(ElectricityController());
            Get.put(ReadMeterController());
          }),
          initialRoute: RoutesPath.splashPage,
          onGenerateRoute: (settings) {
            return RoutesPath.routesFactory(settings);
          },
        );
      },
    );
  }
}
