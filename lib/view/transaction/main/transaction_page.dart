import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';

import '../../../utils/themes.dart';
import '../../home/controller/home_controller.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.getScaffoldColor(context),
        leadingWidth: 200.w,
        leading: Padding(
          padding: CommonMethods.appPadding(),
          child: CommonMethods.appTexts(
            context,
            "History",
            color: Themes.getTextColor(context),
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
          ),
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
                      return Container(
                          height: 200.h,
                          width: double.infinity,
                          child: Shimmer.fromColors(
                            baseColor:
                                Themes.getCardColor(context).withOpacity(0.7),
                            highlightColor: Themes.getPrimaryColor(context)
                                .withOpacity(0.2),
                            child: ListView.builder(
                              itemCount: 4, // Number of shimmering items
                              itemBuilder: (_, __) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 80.h,
                                  decoration: CommonMethods.getBoxDecoration(
                                    cornerRadius: 20.r,
                                    color: Themes.getPrimaryColor(context)
                                        .withOpacity(0.3),
                                  ),
                                  child: ListTile(
                                    title: Container(
                                      height: 30.h,
                                      color: Themes.getPrimaryColor(context)
                                          .withOpacity(0.2),
                                    ),
                                    // subtitle: Container(
                                    //   height: 10.h,
                                    //   color: Themes.getPrimaryColor(context)
                                    //       .withOpacity(0.2),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ));
                    } else if (homeController.transaction.isNotEmpty) {
                      return Column(
                        children: homeController.transaction.map((rowData) {
                          return animationFunction(
                              1,
                              slideDuration: Duration(seconds: 1),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: GestureDetector(
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
                                          'created_at':
                                          '${rowData['created_at']}',
                                          'phone_number':
                                          '${rowData['phone_number']}',
                                          'meter': '${rowData['meter']}',
                                          'customer_name':
                                          '${rowData['customer_name']}',
                                          'address':
                                          '${rowData['address']}',
                                          'token': '${rowData['token']}',
                                          'service_provider':
                                          '${rowData['service_provider']}',
                                        });
                                  },
                                  child: Container(
                                    height: 80.h,
                                    decoration:
                                    CommonMethods.getBoxDecoration(
                                      cornerRadius: 20.r,
                                      color: Themes.getCardColor(context),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 16.w,
                                        right: 17.71.w,
                                      ),
                                      child: Row(
                                        children: [
                                          // CommonMethods.imagesOfApp(
                                          //   image!,
                                          //   width: 20.h,
                                          //   height: 20.h,
                                          //   color: Themes.getTextColor(context),
                                          // ),
                                          // CommonMethods.sizedBox(width: 12.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                CommonMethods.appTexts(
                                                  context,
                                                  rowData['meter']
                                                      .toString(),
                                                  color:
                                                  Themes.getTextColor(
                                                      context),
                                                  fontSize: 16.sp,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                                CommonMethods.sizedBox(
                                                    height: 5.h),
                                                CommonMethods.appTexts(
                                                  context,
                                                  rowData['address'] ==
                                                      'null'
                                                      ? '--'
                                                      : rowData['address']
                                                      .toString(),
                                                  color:
                                                  Themes.getTextColor(
                                                      context),
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                ),
                                              ],
                                            ),
                                          ),
                                          CommonMethods.appTexts(
                                            context,
                                            rowData['amount'].toString(),
                                            color: Themes.getTextColor(
                                                context),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        }).toList(),
                      );
                    } else {
                      return CommonMethods.appTexts(
                        context,
                        'No recent transactions',
                        color: Themes.getTextColor(context),
                        fontSize: 15.sp,
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
