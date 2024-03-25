import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import '../../electricity/view/category_electricity_bill_page.dart';
import '../../home/others/categories.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final List<ElectricityCompany> companies = [
    ElectricityCompany(
        name: "Ikeja",
        alias: "IKEDC",
        image: 'assets/svg/ikeja.png',
        regions: ["lagos-ikeja"]),
    ElectricityCompany(
        name: "Eko",
        alias: "EKEDC",
        image: 'assets/svg/ekedc.png',
        regions: ["lagos-eko"]),
    ElectricityCompany(
        name: "Kano",
        alias: "KEDCO",
        image: 'assets/svg/kedco.png',
        regions: ["kano", "katsina", "jigawa"]),
    ElectricityCompany(
        name: "Port Harcourt",
        alias: "PHED",
        image: 'assets/svg/phed.png',
        regions: ["rivers", "bayelsa", "crossriver", "akwaibom"]),
    ElectricityCompany(
        name: "Jos",
        alias: "JED",
        image: 'assets/svg/jedc.jpg',
        regions: ["bauchi", "benue", "gombe", "plateau"]),
    ElectricityCompany(
        name: "Ibadan",
        alias: "IBEDC",
        image: 'assets/svg/ibedc.png',
        regions: ["oyo", "ogun", "osun", "kwara", "ekiti", "kogi"]),
    ElectricityCompany(
        name: "Kaduna",
        alias: "KAEDC",
        image: 'assets/svg/kaedc.jpg',
        regions: ["kaduna", "kebbi", "sokoto", "zamfara"]),
    ElectricityCompany(
        name: "Abuja",
        alias: "AEDC",
        image: 'assets/svg/aedc.jpg',
        regions: ["fct-abuja", "niger", "nassarawa"]),
    ElectricityCompany(
        name: "Enugu",
        alias: "EEDC",
        image: 'assets/svg/eedc.png',
        regions: ["abia", "anambra", "ebonyi", "enugu", "imo"]),
    ElectricityCompany(
        name: "Benin",
        alias: "BEDC",
        image: 'assets/svg/bedc.jpg',
        regions: ["delta", "edo", "ondo"]),

    ElectricityCompany(
        name: "Yola",
        alias: "YEDC",
        image: 'assets/svg/yedc.jpg',
        regions: ["adamawa", "borno", "taraba"]),
    // Add more company data here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonMethods.appBar(
        onTap: () {
          CommonMethods.jumpOutFromScreen(context);
        },
        backgroundColor: Themes.getScaffoldColor(context),
        title: CommonMethods.appTexts(
          context,
          AppText.categories,
          color: Themes.getTextColor(context),
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(
              color: Themes.getDividerColor(context),
            ),
            CommonMethods.sizedBox(height: 16.h),
            Padding(
              padding: CommonMethods.appPadding(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonMethods.appTexts(
                    context,
                    'Select Electricity company',
                    textAlign: TextAlign.center,
                    color: Themes.getTextColor(context),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  CommonMethods.sizedBox(height: 16.h),
                  GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: companies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = companies[index];
                      return animationFunction(
                          index,
                          // ignore: prefer_const_constructors
                          slideDuration: Duration(seconds: 2),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => CategoryElectricityBillPage(
                                      regions: companies[index].regions),
                                  transition: Transition.rightToLeftWithFade);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Border color
                                  width: 0.5, // Border width
                                ),
                                // boxShadow: [
                                //   // to make elevation
                                //   // BoxShadow(
                                //   //   color: Colors.grey.withOpacity(0.5),
                                //   //   spreadRadius: 1,
                                //   //   blurRadius: 7,
                                //   //   offset: const Offset(0, 0.5),
                                //   // ),
                                // ],
                              ),
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(8.0),
                              child: CommonMethods.imagesOfApp(item.image,
                                  width: 100.h),
                            ),
                          ));
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // mainAxisExtent: 115.h,
                    ),
                  ),
                  CommonMethods.sizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
