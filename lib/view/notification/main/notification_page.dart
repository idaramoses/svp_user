import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import '../../home/controller/home_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.getScaffoldColor(context),
        title: CommonMethods.appTexts(
          context,
          AppText.notifications,
          color: Themes.getTextColor(context),
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
          child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => Padding(
          padding: CommonMethods.appPadding(),
          child: GetBuilder(
            builder: (homeController) {
              return ListView(
                children: [
                  Divider(
                    color: Themes.getDividerColor(context),
                  ),
                  CommonMethods.sizedBox(height: 10.h),
                  Obx(() {
                    if (homeController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (homeController.transaction.isEmpty) {
                      return CommonMethods.appTexts(
                        context,
                        'No Recent Notification',
                        color: Themes.getTextColor(context),
                        fontSize: 15.sp,
                      );
                    } else {
                      return Column(
                        children: homeController.transaction.map((rowData) {
                          return animationFunction(
                              1,
                              // ignore: prefer_const_constructors
                              slideDuration: Duration(seconds: 1),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Card(
                                  color: Themes.getCardColor(context),
                                  child: ListTile(
                                    // leading: Container(
                                    //   height: 40.h,
                                    //   width: 40.h,
                                    //   decoration: const BoxDecoration(
                                    //     shape: BoxShape.circle,
                                    //     color: Colors.white,
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //           color: Color(0x14000000),
                                    //           offset: Offset(0, 1),
                                    //           blurRadius: 17,
                                    //           spreadRadius: 0)
                                    //     ],
                                    //   ),
                                    //   child: Padding(
                                    //     padding: EdgeInsets.all(10.h),
                                    //     child: CommonMethods.imagesOfApp(
                                    //         AppImages.selectNotification),
                                    //   ),
                                    // ),
                                    onTap: () {
                                      CommonMethods.sendToNextScreen(context,
                                          RoutesPath.transactionDetailPage,
                                          arguments: {
                                            'id': '${rowData['id']}',
                                            'transaction_id':
                                                '${rowData['transaction_id']}',
                                            'amount': '${rowData['amount']}',
                                            'status': '${rowData['status']}',
                                            'email': '${rowData['email']}',
                                            'meter': '${rowData['meter']}',
                                            'customer_name':
                                                '${rowData['customer_name']}',
                                            'address': '${rowData['address']}',
                                            'token': '${rowData['token']}',
                                            'service_provider':
                                                '${rowData['service_provider']}',
                                          });
                                    },
                                    title: CommonMethods.appTexts(
                                      context,
                                      rowData['status'] ==
                                              'TRANSACTION SUCCESSFUL'
                                          ? '${rowData['service_provider']} bill has been successfully paid '
                                          : '${rowData['service_provider']} bill has failed',
                                      color: Themes.getTextColor(context),
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    // trailing: CommonMethods.appTexts(
                                    //   context,
                                    //   '${timeago.format(DateTime.parse("${rowData['created_at']}"), locale: 'en_short')} ago',
                                    //   color: Themes.getTextColor(context),
                                    //   fontSize: 14.sp,
                                    // ),
                                    // Add other widgets to display data as needed
                                  ),
                                ),
                              ));
                        }).toList(),
                      );
                    }
                  }),
                ],
              );
            },
            init: HomeController(),
          ),
        ),
      )),
    );
  }
}
