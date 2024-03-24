import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../res/common/app_button.dart';
import '../../../../res/common/app_methods.dart';
import '../../../../res/common/app_textfield.dart';
import '../../../../res/constant/app_strings.dart';
import '../../../../utils/themes.dart';
import '../../controller/electricity_controller.dart';

class MaharashtraElectricityPage extends StatefulWidget {
  const MaharashtraElectricityPage({super.key});

  @override
  State<MaharashtraElectricityPage> createState() =>
      _MaharashtraElectricityPageState();
}

class _MaharashtraElectricityPageState
    extends State<MaharashtraElectricityPage> {
  ElectricityController electricityController =
      Get.put(ElectricityController());

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
          AppText.maharashtraElectricity,
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
            CommonMethods.sizedBox(height: 24.h),
            Container(
              height: 354.h,
              width: double.infinity,
              margin: CommonMethods.appPadding(),
              decoration: CommonMethods.getBoxDecoration(
                cornerRadius: 16.r,
                color: Themes.getScaffoldColor(context),
                shadows: [
                  const BoxShadow(
                      color: Color(0x14000000),
                      spreadRadius: 0,
                      blurRadius: 17,
                      offset: Offset(0, 1))
                ],
              ),
              child: Padding(
                padding: CommonMethods.appPadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonMethods.sizedBox(height: 24.h),
                    CommonMethods.appTexts(
                      context,
                      AppText.link,
                      color: Themes.getTextColor(context),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    CommonMethods.sizedBox(height: 32.h),
                    AppTextFieldScreen(
                      // controller: electricityController.accountNameController,
                      isDense: true,
                      hintText: AppText.accountName,
                      label: CommonMethods.appTexts(
                        context,
                        AppText.accountName,
                      ),
                      textInputType: TextInputType.name,
                      keyboardType: TextInputAction.next,
                      validator: (val) {
                        if (val!.trim().isNotEmpty) {
                          if (val.trim().isEmpty) {
                            return "Enter Account Number";
                          }
                          return null;
                        }
                        return "enter account number";
                      },
                    ),
                    CommonMethods.sizedBox(height: 24.h),
                    CommonMethods.sizedBox(height: 48.h),
                    GestureDetector(
                      onTap: () {
                        postBill();
                      },
                      child: const AppButton(
                        text: AppText.payBill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void postBill() async {
    final url = Uri.parse('https://api.flutterwave.com/v3/bills');
    final headers = {
      'Authorization': 'Bearer FLWSECK_TEST-dad2cd8f7272483c00718516d9d8a747-X',
      'Content-Type': 'application/json',
    };
    final reference = DateTime.now().millisecondsSinceEpoch.toString();
    final body = jsonEncode({
      "country": "NG",
      "customer": "9540803303",
      "amount": 12000,
      "type": "EKEDC PREPAID TOPUP",
      "reference": reference
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
      } else {
        print('Request failed with status: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
