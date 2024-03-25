import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';

import '../../../res/common/app_button.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import '../../home/controller/home_controller.dart';

class PaymentTransactionDetailPage extends StatefulWidget {
  const PaymentTransactionDetailPage({super.key});

  @override
  State<PaymentTransactionDetailPage> createState() =>
      _PaymentTransactionDetailPageState();
}

class _PaymentTransactionDetailPageState
    extends State<PaymentTransactionDetailPage> {
  final SuperbaseServices superbaseService = SuperbaseServices();

  RxList<Map<String, dynamic>> tableData = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  bool Loading = false;

  @override
  void onInit() {
    // Fetch data when the controller is initialized
    String transferdata = Get.arguments ?? '';
    fetchTableData('transactions', 1);
  }

  Future<void> fetchTableData(String tableName, int id) async {
    isLoading.value = true;
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = Get.arguments;
    DateTime now = DateTime.now();

    // Format the current time as desired
    String formattedTime = DateFormat('yyyy-MM-dd').format(now);
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press here
        // Return true to allow back navigation, false to prevent it
        // Example: show a dialog and return false to prevent back navigation
        Get.toNamed(RoutesPath.bottomBarPage);
        return false; // Prevent back navigation
      },
      child: Scaffold(
        appBar: CommonMethods.appBar(
          onTap: () {
            Get.toNamed(RoutesPath.bottomBarPage);

          },
          backgroundColor: Themes.getScaffoldColor(context),
          title: CommonMethods.appTexts(
            context,
            AppText.transDetail,
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
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CommonMethods.sizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded( flex:3, child:
                        CommonMethods.appTexts(
                          context,
                          "Customer name:",
                          color: Themes.getHintTextColor(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        ),
                        Expanded( flex:7, child: CommonMethods.appTexts(
                          context,
                          '${args['customer_name']}',
                          color: Themes.getTextColor(context),
                          fontSize: 15.sp,
                          textAlign: TextAlign.right,
                          fontWeight: FontWeight.w400,
                        ),
                        ),
                      ],
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),

                    CommonMethods.sizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded( flex:3,child:  CommonMethods.appTexts(
                          context,
                          "Meter",
                          color: Themes.getHintTextColor(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        ),
                        Expanded( flex:7, child:
                        CommonMethods.appTexts(
                            context,
                            '${args['meter']}',
                            color: Themes.getTextColor(context),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.right
                        ),
                        )
                      ],
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded( flex:3, child:  CommonMethods.appTexts(
                          context,
                          "Email",
                          color: Themes.getHintTextColor(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        ),
                        Expanded( flex:7, child:
                        CommonMethods.appTexts(
                            context,
                            '${args['email']}',
                            color: Themes.getTextColor(context),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.right
                        ),
                        )
                      ],
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded( flex:3, child: CommonMethods.appTexts(
                          context,
                          "Date",
                          color: Themes.getHintTextColor(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        ),
                        Expanded( flex:7, child:
                        CommonMethods.appTexts(
                            context,
                            '${formattedTime}',
                            color: Themes.getTextColor(context),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.right
                        ))
                      ],
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded( flex:3, child:
                        CommonMethods.appTexts(
                          context,
                          "Amount",
                          color: Themes.getHintTextColor(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        )),
                        Expanded( flex:4, child:
                        CommonMethods.appTexts(
                          context,
                          '${args['amount']}',
                          color: Themes.getTextColor(context),
                          fontSize: 15.sp,
                          textAlign: TextAlign.right,
                          fontWeight: FontWeight.w500,
                        ))
                      ],
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded( flex:3, child:
                        CommonMethods.appTexts(
                          context,
                          "Transaction ID",
                          color: Themes.getHintTextColor(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),),
                        Expanded( flex:7, child:
                        CommonMethods.appTexts(
                          context,
                          '${args['transaction_id']}',
                          color: Themes.getTextColor(context),
                          fontSize: 15.sp,
                          textAlign: TextAlign.right,
                          fontWeight: FontWeight.w500,
                        ),
                        )
                      ],
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded( flex:3, child:  CommonMethods.appTexts(
                          context,
                          "Token",
                          color: Themes.getHintTextColor(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        ),
                        Expanded( flex:7, child:
                        CommonMethods.appTexts(
                          context,
                          args['token'] == 'null' ? '--' : '${args['token']}',
                          color: Themes.getTextColor(context),
                          fontSize: 15.sp,
                          textAlign: TextAlign.right,
                          fontWeight: FontWeight.w500,
                        ),
                        )
                      ],
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded( flex:3, child:
                        CommonMethods.appTexts(
                          context,
                          "Phone number",
                          color: Themes.getHintTextColor(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        ),
                        Expanded( flex:7, child:
                        CommonMethods.appTexts(
                          context,
                          '${args['phone_number']}',
                          color: Themes.getTextColor(context),
                          fontSize: 15.sp,
                          textAlign: TextAlign.right,
                          fontWeight: FontWeight.w500,
                        ),
                        )
                      ],
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded( flex:3, child: CommonMethods.appTexts(
                          context,
                          "Service Provider",
                          color: Themes.getHintTextColor(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        ),
                        Expanded( flex:7, child: CommonMethods.appTexts(
                            context,
                            '${args['service_provider']}',
                            color: Themes.getTextColor(context),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.right
                        ))
                      ],
                    ),
                    CommonMethods.sizedBox(height: 6.h),
                    Divider(
                      color: Themes.getDividerColor(context),
                    ),
                    CommonMethods.sizedBox(height: 40.h),
                    GestureDetector(
                      onTap: () {
                        downloadrecipt('${args['transaction_id']}');
                      },
                      child: const AppButton(
                        text: 'Download Receipt',
                      ),
                    ),
                    CommonMethods.sizedBox(height: 15.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> downloadrecipt(String url) async {
    Map<String, dynamic> args = Get.arguments;
    // Generate PDF
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Stack(
            children: [
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    "Transaction Details",
                    style: pw.TextStyle(
                      fontSize: 20.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 20.h,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Token: ",
                        style: pw.TextStyle(
                          fontSize: 20.sp,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        args['token'] == 'null' ? '--' : '${args['token']}',
                        style: pw.TextStyle(
                          fontSize: 20.sp,
                          color: PdfColor.fromHex('#be9306'),
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 20.h,
                  ),
                  pw.ListView(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Meter",
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            '${args['meter']}',
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Customer name",
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            '${args['customer_name']}',
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Email",
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            '${args['email']}',
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Date",
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            '${args['created_at']}',
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Amount",
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            '${args['amount']}',
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Transaction ID",
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            '${args['transaction_id']}',
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Token",
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            args['token'] == 'null' ? '--' : '${args['token']}',
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Phone number",
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            '${args['phone_number']}',
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Service Provider",
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            '${args['service_provider']}',
                            style: pw.TextStyle(
                              fontSize: 16.sp,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: pw.Container(
                    height: 30,
                    width: double.infinity,
                    color: PdfColor.fromHex('#be9306'),
                    child: pw.Center(
                      child: pw.Text(
                        'Keep the light on',
                        style: pw.TextStyle(
                          fontSize: 16.sp,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    )),
              ),
              pw.Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: pw.Container(
                    height: 30,
                    width: double.infinity,
                    color: PdfColor.fromHex('#be9306'),
                    child: pw.Center(
                      child: pw.Text(
                        ' 2024 SparkHub | All rights reserved',
                        style: pw.TextStyle(
                          fontSize: 16.sp,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    )),
              ),
            ],
          );
        },
      ),
    );

    // Save PDF to device
    final output = await getDownloadsDirectory();
    final file = File("${output?.path}/receipt${url}.pdf");
    await file.writeAsBytes(await pdf.save());

    // Share PDF
    Share.shareFiles([file.path], text: 'Reciept pdf');
    // Share PDF
    // Share.shareFiles([file.path], text: 'Check out my PDF!');
  }
}
