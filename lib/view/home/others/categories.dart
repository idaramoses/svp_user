import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharkhub/view/home/controller/home_controller.dart';

import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import '../../electricity/view/category_electricity_bill_page.dart';

class ElectricityCompany {
  final String name;
  final String alias;
  final String image;
  final List<String> regions;

  ElectricityCompany(
      {required this.name,
      required this.alias,
      required this.image,
      required this.regions});
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<ElectricityCompany> companies = [
    ElectricityCompany(
        name: "Abuja",
        alias: "AEDC",
        image: 'assets/svg/aedc.jpg',
        regions: ["fct-abuja", "niger", "nassarawa"]),
    ElectricityCompany(
        name: "Jos",
        alias: "JED",
        image: 'assets/svg/jedc.jpg',
        regions: ["bauchi", "benue", "gombe", "plateau"]),
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
  void initState() {
    super.initState();
    // Parse the JSON data and store it in the itemList
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (controller) {
        return Padding(
          padding: CommonMethods.appPadding(),
          child: Column(
            children: [
              CommonMethods.sizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: CommonMethods.appTexts(
                      context,
                      AppText.categories,
                      color: Themes.getTextColor(context),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                ],
              ),
              CommonMethods.sizedBox(height: 16.h),
              Divider(
                color: Themes.getDividerColor(context),
              ),
              CommonMethods.sizedBox(height: 16.h),
              SizedBox(
                height: 220.h,
                width: double.maxFinite,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.categoriesScrollController,
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    final item = companies[index];
                    return animationFunction(
                        index,
                        // ignore: prefer_const_constructors
                        slideDuration: Duration(seconds: 2),
                     index==7?  GestureDetector(
                          onTap: () {
                            CommonMethods.sendToNextScreen(
                                context, RoutesPath.categoriesPage);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 65.h,
                                height: 65.h,
                                decoration: BoxDecoration(
                                  color: Themes.getPrimaryColor(context).withOpacity(0.1),
                                  shape: BoxShape.circle,
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
                                child: Center(
                                  child: Container(
                                      child:   Icon(
                                        CupertinoIcons.arrow_right,
                                        size: 30.h,
                                        color: Themes.getPrimaryColor(context),
                                      ),

                                  ),
                                ),
                              ),
                              CommonMethods.sizedBox(height: 10.h),
                              CommonMethods.appTexts(
                                context,
                               'View all',
                                color: Themes.getPrimaryColor(context),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ],
                          ),
                        ): GestureDetector(
                       onTap: () {
                         Get.to(
                                 () => CategoryElectricityBillPage(
                                 regions: companies[index].regions),
                             transition: Transition.rightToLeftWithFade);
                         print(companies[index].regions);
                       },
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                             width: 65.h,
                             height: 65.h,
                             decoration: BoxDecoration(
                               color: Themes.getCardColor(context),
                               shape: BoxShape.circle,
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
                             child: Center(
                               child: Container(
                                   child: CommonMethods.imagesOfApp(
                                       item.image,
                                       width: 40.h,
                                       height: 40.h)),
                             ),
                           ),
                           CommonMethods.sizedBox(height: 10.h),
                           CommonMethods.appTexts(
                             context,
                             item.alias,
                             color: Themes.getTextColor(context),
                             fontSize: 13.sp,
                             fontWeight: FontWeight.w500,
                           ),
                         ],
                       ),
                     )

                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    // mainAxisExtent: 115.h,
                  ),
                ),
              ),
              CommonMethods.sizedBox(height: 24.h),
            ],
          ),
        );
      },
      init: HomeController(),
    );
  }
}
