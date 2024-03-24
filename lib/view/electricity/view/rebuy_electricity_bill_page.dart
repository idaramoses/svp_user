import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// import 'package:pay_with_paystack/pay_with_paystack.dart';

import '../../../main.dart';
import '../../../res/common/app_button.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/common/app_textfield.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import '../controller/electricity_controller.dart';

class StateModel {
  final int id;
  final String name;

  StateModel(this.id, this.name);
}

class RebuyElectricityBillPage extends StatefulWidget {
  const RebuyElectricityBillPage({super.key});

  @override
  State<RebuyElectricityBillPage> createState() =>
      _RebuyElectricityBillPageState();
}

class _RebuyElectricityBillPageState extends State<RebuyElectricityBillPage> {
  ElectricityController electricityController =
      Get.put(ElectricityController());
  int selectedIndex = 1;
  double _progressValue = 0.2;
  late TabController tabviewController;
  bool isLoading = false;
  late String companyName,
      image,
      state,
      Customer_Name,
      Address,
      MeterNumber,
      Customer_Phone,
      Meter_Type,
      tansactionId,
      tx_ref;
  String token = '';
  final formKey = GlobalKey<FormState>();
  String selectedValue = 'Prepaid';

  bool isTestMode = true;
  bool error = false;
  bool success = true;

  @override
  void initState() {
    String transferdata = Get.arguments ?? '';
    selectstate(transferdata);
  }
  // @override
  // void onInit() {
  //   // Fetch data when the controller is initialized
  //   String transferdata = Get.arguments ?? '';
  //   selectstate(transferdata);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonMethods.appBar(
            onTap: () {
              CommonMethods.jumpOutFromScreen(context);
            },
            backgroundColor: Themes.getScaffoldColor(context),
            title: CommonMethods.appTexts(
              context,
              'Buy Electricity',
              color: Themes.getTextColor(context),
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
            actions: []),
        body: Column(
          children: [
            CommonMethods.sizedBox(height: 16.h),
            // Text(
            //   '${token}' ?? '',
            //   style: TextStyle(
            //     color: Themes.getTextColor(context),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 9.h,
              ),
              child: LinearProgressIndicator(
                value: _progressValue,
                backgroundColor: Themes.getCardColor(context),
                minHeight: 15.h,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
            // Container(
            //   height: 60.h,
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 10.w,
            //     vertical: 9.h,
            //   ),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         InkWell(
            //           child: Container(
            //             padding: EdgeInsets.symmetric(horizontal: 15),
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //               border: Border(
            //                 bottom: BorderSide(
            //                   color: selectedIndex == 0
            //                       ? Themes.getPrimaryColor(context)
            //                       : Colors.transparent,
            //                   width: 2,
            //                 ),
            //               ),
            //             ),
            //             child: Text(
            //               'Select Location',
            //               style: TextStyle(
            //                 fontSize: 14.sp,
            //                 fontWeight: selectedIndex == 0
            //                     ? FontWeight.bold
            //                     : FontWeight.w300,
            //                 color: selectedIndex == 0
            //                     ? Themes.getTextColor(context)
            //                     : Themes.getTextColor(context)
            //                         .withOpacity(0.7),
            //               ),
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           child: Container(
            //             padding: EdgeInsets.symmetric(horizontal: 15),
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //               border: Border(
            //                 bottom: BorderSide(
            //                   color: selectedIndex == 1
            //                       ? Themes.getPrimaryColor(context)
            //                       : Colors.transparent,
            //                   width: 2,
            //                 ),
            //               ),
            //             ),
            //             child: Text(
            //               'Meter Details',
            //               style: TextStyle(
            //                 fontSize: 14.sp,
            //                 fontWeight: selectedIndex == 1
            //                     ? FontWeight.bold
            //                     : FontWeight.w300,
            //                 color: selectedIndex == 1
            //                     ? Themes.getTextColor(context)
            //                     : Themes.getTextColor(context)
            //                         .withOpacity(0.7),
            //               ),
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           child: Container(
            //             padding: EdgeInsets.symmetric(horizontal: 15),
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //               border: Border(
            //                 bottom: BorderSide(
            //                   color: selectedIndex == 2
            //                       ? Themes.getPrimaryColor(context)
            //                       : Colors.transparent,
            //                   width: 2,
            //                 ),
            //               ),
            //             ),
            //             child: Text(
            //               'Confirm Details',
            //               style: TextStyle(
            //                 fontSize: 14.sp,
            //                 fontWeight: selectedIndex == 2
            //                     ? FontWeight.bold
            //                     : FontWeight.w300,
            //                 color: selectedIndex == 2
            //                     ? Themes.getTextColor(context)
            //                     : Themes.getTextColor(context)
            //                         .withOpacity(0.7),
            //               ),
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           child: Container(
            //             padding: EdgeInsets.symmetric(horizontal: 15),
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //               border: Border(
            //                 bottom: BorderSide(
            //                   color: selectedIndex == 3
            //                       ? Themes.getPrimaryColor(context)
            //                       : Colors.transparent,
            //                   width: 2,
            //                 ),
            //               ),
            //             ),
            //             child: Text(
            //               'Make Payment',
            //               style: TextStyle(
            //                 fontSize: 14.sp,
            //                 fontWeight: selectedIndex == 3
            //                     ? FontWeight.bold
            //                     : FontWeight.w300,
            //                 color: selectedIndex == 3
            //                     ? Themes.getTextColor(context)
            //                     : Themes.getTextColor(context)
            //                         .withOpacity(0.7),
            //               ),
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           child: Container(
            //             padding: EdgeInsets.symmetric(horizontal: 15),
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //               border: Border(
            //                 bottom: BorderSide(
            //                   color: selectedIndex == 4
            //                       ? Themes.getPrimaryColor(context)
            //                       : Colors.transparent,
            //                   width: 2,
            //                 ),
            //               ),
            //             ),
            //             child: Text(
            //               'Complete Order',
            //               style: TextStyle(
            //                 fontSize: 14.sp,
            //                 fontWeight: selectedIndex == 4
            //                     ? FontWeight.bold
            //                     : FontWeight.w300,
            //                 color: selectedIndex == 4
            //                     ? Themes.getTextColor(context)
            //                     : Themes.getTextColor(context)
            //                         .withOpacity(0.7),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            CommonMethods.sizedBox(height: 16.h),
            selectedIndex == 0
                ? Expanded(
                    child: Padding(
                      padding: CommonMethods.appPadding(),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Themes.getPrimaryColor(context),
                            ))
                          : Column(
                              children: [
                                Card(
                                  color: Themes.getCardColor(context),
                                  child: TextField(
                                    onChanged:
                                        electricityController.searchStates,
                                    decoration: InputDecoration(
                                      hintText: 'Search for a state...',
                                      hintStyle: TextStyle(
                                        color: Themes.getTextColor(context),
                                      ),
                                      labelStyle: TextStyle(
                                        color: Themes.getTextColor(context),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Themes.getTextColor(context),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Obx(
                                    () => ListView.builder(
                                      itemCount: electricityController
                                          .displayedStates.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: Themes.getCardColor(context),
                                          child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                state =
                                                    '${electricityController.displayedStates[index].name}';
                                                isLoading = true;
                                              });
                                              selectstate(
                                                  '${electricityController.displayedStates[index].name}');
                                              // postData();
                                            },
                                            title: Text(
                                              '${electricityController.displayedStates[index].name}',
                                              style: TextStyle(
                                                color: Themes.getTextColor(
                                                    context),
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Themes.getTextColor(
                                                  context),
                                            ),
                                            // Add onTap if you want to handle taps on each state
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // Add other widgets below the ListView if needed
                              ],
                            ),
                    ),
                  )
                : Container(),
            selectedIndex == 1
                ? Expanded(
                    child: Padding(
                      padding: CommonMethods.appPadding(),
                      child: Form(
                        key: formKey,
                        child: ListView(
                          children: [
                            ListTile(
                              leading: SvgPicture.network(
                                "$image",
                                height: 45.h,
                                width: 45.h,
                                placeholderBuilder: (BuildContext context) =>
                                    Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              title: Text(
                                '$companyName'.toUpperCase(),
                                style: TextStyle(
                                  color: Themes.getTextColor(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '$state',
                                style: TextStyle(
                                  color: Themes.getTextColor(context),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            CommonMethods.sizedBox(height: 10.h),
                            Divider(
                              color: Themes.getDividerColor(context),
                            ),
                            CommonMethods.sizedBox(height: 10.h),
                            AppTextFieldScreen(
                              controller: electricityController.emailController,
                              isDense: true,
                              hintText: AppText.emailHint,
                              label: CommonMethods.appTexts(
                                context,
                                AppText.emailHint,
                              ),
                              textInputType: TextInputType.emailAddress,
                              keyboardType: TextInputAction.next,
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  if (!RegExp(
                                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                      .hasMatch(val)) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                }
                                return "Please enter a valid email address";
                              },
                            ),
                            CommonMethods.sizedBox(height: 24.h),
                            AppTextFieldScreen(
                              controller:
                                  electricityController.phonenumberController,
                              isDense: true,
                              hintText: 'Phone Number',
                              label: CommonMethods.appTexts(
                                context,
                                'Phone Number',
                              ),
                              textInputType: TextInputType.phone,
                              keyboardType: TextInputAction.next,
                              validator: (val) {
                                if (val!.trim().isNotEmpty) {
                                  if (val.trim().isEmpty) {
                                    return "Please enter a valid phone number";
                                  }
                                  return null;
                                }
                                return "Please enter a valid phone number";
                              },
                            ),
                            CommonMethods.sizedBox(height: 24.h),
                            AppTextFieldScreen(
                              controller: electricityController.meterController,
                              isDense: true,
                              hintText: 'Meter Number',
                              label: CommonMethods.appTexts(
                                context,
                                'Meter Number',
                              ),
                              textInputType: TextInputType.phone,
                              keyboardType: TextInputAction.next,
                              validator: (val) {
                                if (val!.trim().isNotEmpty) {
                                  if (val.trim().isEmpty) {
                                    return "Please enter a valid meter number";
                                  }
                                  return null;
                                }
                                return "Please enter a valid meter number";
                              },
                            ),
                            CommonMethods.sizedBox(height: 24.h),
                            AppTextFieldScreen(
                              controller: electricityController.amount,
                              isDense: true,
                              hintText: 'Amount',
                              label: CommonMethods.appTexts(
                                context,
                                'Amount',
                              ),
                              textInputType: TextInputType.phone,
                              keyboardType: TextInputAction.next,
                              validator: (val) {
                                if (val!.trim().isNotEmpty) {
                                  if (val.trim().isEmpty) {
                                    return "Please enter a valid meter amount";
                                  }
                                  return null;
                                }
                                return "Please enter a valid meter amount";
                              },
                            ),
                            CommonMethods.sizedBox(height: 24.h),
                            Container(
                              height: 50.h,
                              width: double.infinity,
                              decoration: CommonMethods.getBoxDecoration(
                                cornerRadius: 16.r,
                                borderColor: Themes.getTextColor(context)!
                                    .withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: CommonMethods.appPadding(),
                                child: Row(
                                  children: [
                                    DropdownButton<String>(
                                      value: selectedValue,
                                      dropdownColor:
                                          Themes.getCardColor(context),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedValue = newValue!;
                                        });
                                      },
                                      items: <String>['Prepaid', 'Postpaid']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              color: Themes.getTextColor(
                                                  context),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CommonMethods.sizedBox(height: 24.h),
                            isLoading
                                ? Container(
                                    height: 54.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(64.r),
                                      color: Themes.getPrimaryColor(context),
                                    ),
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )))
                                : GestureDetector(
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        debugPrint("Success");
                                        setState(() {
                                          isLoading = true;
                                        });
                                        final url = Uri.parse(
                                            'https://sparkhub.ng/api/meter/verify?meter=${electricityController.meterController.text}&location=${state.toLowerCase().replaceAll(' ', '')}&type=${selectedValue}');
                                        // final Map<String, dynamic> data = {
                                        //   "meter": "1111111111111",
                                        //   "location": "akwaibom",
                                        //   "type": "prepaid"
                                        // };
                                        try {
                                          final response = await http.get(
                                            url,
                                            // body: jsonEncode(data),
                                            headers: {
                                              'Content-Type':
                                                  'application/json',
                                              // Add any additional headers here
                                            },
                                          );

                                          if (response.statusCode == 200) {
                                            // Request was successful
                                            print('Response: ${response.body}');
                                            final decodedData =
                                                json.decode(response.body);
                                            print(
                                                'Decoded Data: ${decodedData['Customer_Name']}');
                                            setState(() {
                                              Customer_Name =
                                                  '${decodedData['Customer_Name']}';
                                              Address =
                                                  '${decodedData['Address']}';
                                              MeterNumber =
                                                  '${decodedData['MeterNumber']}';
                                              Customer_Phone =
                                                  '${decodedData['Customer_Phone']}';
                                              Meter_Type =
                                                  '${decodedData['Meter_Type']}';
                                              selectedIndex = 2;
                                              _progressValue = 0.6;
                                              isLoading = false;
                                            });
                                          } else {
                                            // Request failed with an error
                                            Get.snackbar(
                                              'Error',
                                              'Invalid meter number',
                                              snackPosition: SnackPosition.TOP,
                                              colorText: Colors.white,
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 1),
                                            );
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        } catch (e) {
                                          // Handle exceptions
                                          Get.snackbar(
                                            'Error',
                                            'Check your network connection',
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 1),
                                          );
                                          setState(() {
                                            isLoading = false;
                                          });
                                          print('Exception: $e');
                                        }
                                      }
                                    },
                                    child: const AppButton(
                                      text: 'Validate',
                                    ),
                                  ),
                            CommonMethods.sizedBox(height: 24.h),
                            Row(
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex = 0;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Themes.getPrimaryColor(context),
                                  ),
                                  label: Text(
                                    'Previous',
                                    style: TextStyle(
                                      color: Themes.getPrimaryColor(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            selectedIndex == 2
                ? Expanded(
                    child: Padding(
                      padding: CommonMethods.appPadding(),
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text(
                              'Confirm Details',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                            subtitle: Text(
                              'Please confirm that the details of your meter are correct before proceeding to pay.',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          CommonMethods.sizedBox(height: 10.h),
                          Divider(
                            color: Themes.getDividerColor(context),
                          ),
                          CommonMethods.sizedBox(height: 10.h),
                          ListTile(
                            title: Text(
                              'Customer Name',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '$Customer_Name',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Divider(
                            color: Themes.getDividerColor(context),
                          ),
                          ListTile(
                            title: Text(
                              'Address',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '$Address',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Divider(
                            color: Themes.getDividerColor(context),
                          ),
                          ListTile(
                            title: Text(
                              'Meter Number',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '$MeterNumber',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Divider(
                            color: Themes.getDividerColor(context),
                          ),
                          ListTile(
                            title: Text(
                              'Customer Phone',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '$Customer_Phone',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Divider(
                            color: Themes.getDividerColor(context),
                          ),
                          ListTile(
                            title: Text(
                              'Meter Type',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '$Meter_Type',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Divider(
                            color: Themes.getDividerColor(context),
                          ),
                          ListTile(
                            title: Text(
                              'Amount',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${electricityController.amount.text}',
                              style: TextStyle(
                                color: Themes.getTextColor(context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Divider(
                            color: Themes.getDividerColor(context),
                          ),
                          CommonMethods.sizedBox(height: 24.h),
                          isLoading
                              ? Container(
                                  height: 54.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(64.r),
                                    color: Themes.getPrimaryColor(context),
                                  ),
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )))
                              : GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    _handlePaymentInitialization();
                                  },
                                  child: const AppButton(
                                    text: 'Proceed to pay',
                                  ),
                                ),
                          CommonMethods.sizedBox(height: 24.h),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Themes.getPrimaryColor(context),
                                ),
                                label: Text(
                                  'Previous',
                                  style: TextStyle(
                                    color: Themes.getPrimaryColor(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CommonMethods.sizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  )
                : Container(),
            selectedIndex == 3
                ? Expanded(
                    child: Padding(
                      padding: CommonMethods.appPadding(),
                      child: ListView(
                        children: [
                          CommonMethods.sizedBox(height: 24.h),
                          error
                              ? Column(
                                  children: [
                                    Container(
                                      width: 120.h, // Adjust the size as needed
                                      height:
                                          120.h, // Adjust the size as needed
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.red,
                                          width: 4.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.clear,
                                          color: Colors.red,
                                          size: 80.h,
                                        ),
                                      ),
                                    ),
                                    CommonMethods.sizedBox(height: 30.h),
                                    Text(
                                      'Oops!',
                                      style: TextStyle(
                                        color: Themes.getTextColor(context),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                    CommonMethods.sizedBox(height: 10.h),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Your payment failed and we are not sure why. Please try again. Fingers crossed!',
                                        style: TextStyle(
                                          color: Themes.getTextColor(context),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    CommonMethods.sizedBox(height: 30.h),
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        _handlePaymentInitialization();
                                      },
                                      child: const AppButton(
                                        text: 'Try again',
                                      ),
                                    ),
                                    CommonMethods.sizedBox(height: 24.h),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = 0;
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 0, 10),
                                        child: Center(
                                          child: Text(
                                            "Restart payment",
                                            style: TextStyle(
                                              color: Themes.getPrimaryColor(
                                                  context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          CommonMethods.sizedBox(height: 24.h),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Themes.getPrimaryColor(context),
                                ),
                                label: Text(
                                  'Previous',
                                  style: TextStyle(
                                    color: Themes.getPrimaryColor(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CommonMethods.sizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  )
                : Container(),
            selectedIndex == 4
                ? Expanded(
                    child: Padding(
                      padding: CommonMethods.appPadding(),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Themes.getPrimaryColor(context),
                            ))
                          : ListView(
                              children: [
                                Container(
                                  width: 120.h, // Adjust the size as needed
                                  height: 120.h, // Adjust the size as needed
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.green,
                                      width: 4.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.check_mark,
                                      color: Colors.green,
                                      size: 80.h,
                                    ),
                                  ),
                                ),
                                CommonMethods.sizedBox(height: 30.h),
                                Text(
                                  'Congratulations!!!',
                                  style: TextStyle(
                                    color: Themes.getTextColor(context),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                CommonMethods.sizedBox(height: 10.h),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Your payment has been completed. View the details of your order below:',
                                    style: TextStyle(
                                      color: Themes.getTextColor(context),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                CommonMethods.sizedBox(height: 30.h),
                                Divider(
                                  color: Themes.getDividerColor(context),
                                ),
                                ListTile(
                                  title: Text(
                                    'Token',
                                    style: TextStyle(
                                      color: Themes.getTextColor(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${token}' ?? '',
                                    style: TextStyle(
                                      color: Themes.getTextColor(context),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Themes.getDividerColor(context),
                                ),
                                ListTile(
                                  title: Text(
                                    'Amount',
                                    style: TextStyle(
                                      color: Themes.getTextColor(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${electricityController.amount.text}',
                                    style: TextStyle(
                                      color: Themes.getTextColor(context),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Themes.getDividerColor(context),
                                ),
                                ListTile(
                                  title: Text(
                                    'Status',
                                    style: TextStyle(
                                      color: Themes.getTextColor(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'TRANSACTION SUCCESSFUL',
                                    style: TextStyle(
                                      color: Themes.getTextColor(context),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                CommonMethods.sizedBox(height: 24.h),
                                isLoading
                                    ? Container(
                                        height: 54.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(64.r),
                                          color:
                                              Themes.getPrimaryColor(context),
                                        ),
                                        child: const Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.white,
                                        )))
                                    : GestureDetector(
                                        onTap: () async {
                                          // _handlePaymentInitialization();
                                        },
                                        child: const AppButton(
                                          text: 'View Full Details',
                                        ),
                                      ),
                                CommonMethods.sizedBox(height: 24.h),
                              ],
                            ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> selectstate(String s) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        'https://sparkhub.ng/api/states/${s.toLowerCase().replaceAll(' ', '')}');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any additional headers here
        },
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('Response: ${response.body}');

        // If the response is in JSON format, you can decode it
        final decodedData = json.decode(response.body);
        print('Decoded Data: ${decodedData['title']}');
        setState(() {
          image = 'https://www.sparkhub.ng${decodedData['image']}';
          companyName = '${decodedData['title']}';
          selectedIndex = 1;
          _progressValue = 0.4;
          isLoading = false;
        });
      } else {
        // Request failed with an error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }

  Future<void> postData() async {
    var url = Uri.parse('https://sparkhub.ng/api/pay');

    // Your JSON data
    var data = {
      // "location": "${state.toLowerCase().replaceAll(' ', '')}",
      // "meter": "${electricityController.meterController.text}",
      // "type": "$selectedIndex",
      // "amount": "${electricityController.amount.text}",

      "location": "${state.toLowerCase().replaceAll(' ', '')}",
      "meter": "${electricityController.meterController.text}",
      "type": "${selectedValue}",
      "amount": "${electricityController.amount.text}",
      "phone": "${electricityController.phonenumberController.text}",
      // "phone": "08108402170"
    };

    // Convert the data to JSON format
    var jsonData = jsonEncode(data);

    // Set the headers
    var headers = {'Content-Type': 'application/json'};

    // Create an http.Client to handle redirects
    var client = http.Client();

    try {
      var response = await client.post(url, headers: headers, body: jsonData);

      // Check for redirects manually
      while (response.statusCode == 308 ||
          response.statusCode == 301 ||
          response.statusCode == 302) {
        var redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          url = Uri.parse(redirectUrl);
          response = await client.post(url, headers: headers, body: jsonData);
        } else {
          print('Error - Redirect location not found.');
          break;
        }
      }

      // Check the final response status
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response,
        // parse the JSON response
        var jsonResponse = jsonDecode(response.body);
        print('${jsonResponse['token']}');
        await supabase.from('transactions').insert({
          "token": "${jsonResponse['token']}",
          "status": "${jsonResponse['status']}",
          "meter": "${jsonResponse['meter']}",
          "transaction_id": "${jsonResponse['transaction_id']}",
          "commission": '${jsonResponse['commission']}',
          "amount_paid": '${jsonResponse['amount_paid']}',
          "service_provider": "${jsonResponse['service_provider']}",
          "amount": '${jsonResponse['amount']}',
          "request_id": "${jsonResponse['request_id']}",
          "customer_name": "${jsonResponse['customer_name']}",
          "address": "${jsonResponse['address']}",
          "units": "${jsonResponse['units']}",
          'user_id': "${electricityController.user_id}",
          'name': "${electricityController.name}",
          'email': "${electricityController.emailController.text}",
          'phone_number': "${electricityController.phonenumberController.text}",
          'flw_tx_id': '$tansactionId',
          'flw_tx_ref': '$tx_ref',
        }).execute();
        setState(() {
          token = '${jsonResponse['token']}';
          isLoading = false;
        });
      } else {
        // If the server did not return a 200 OK response,
        // print the response status and body
        isLoading = false;
        print('Error - Status Code: ${response.statusCode}');
        print('Error - Body: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that may occur during the request
      print('Error: $e');
    } finally {
      // Close the client when done
      client.close();
    }
  }

  _handlePaymentInitialization() async {
    // PayWithPayStack().now(
    //     context: context,
    //     secretKey: "sk_test_25200f962c235342a1a2d8ddc79cf91c1199b7a0",
    //     customerEmail: "popekabu@gmail.com",
    //     reference: DateTime.now().microsecondsSinceEpoch.toString(),
    //     currency: "GHS",
    //     amount: "20000",
    //     transactionCompleted: () {
    //       postData();
    //       setState(() {
    //         isLoading = true;
    //         selectedIndex = 4;
    //         _progressValue = 1;
    //         tansactionId = 'id';
    //         error = false;
    //         success = true;
    //       });
    //     },
    //     transactionNotCompleted: () {
    //       setState(() {
    //         selectedIndex = 3;
    //         _progressValue = 0.8;
    //         error = true;
    //         success = false;
    //       });
    //     },
    //     callbackUrl: 'https://www.sparkhub.ng');
    // Charge charge = Charge()
    //   ..amount = 100000 // Amount in kobo
    //   ..reference = DateTime.now().millisecondsSinceEpoch.toString()
    //   ..email = "${electricityController.emailController.text}";
    //
    // CheckoutResponse response = await plugin.checkout(
    //   context,
    //   charge: charge,
    //   method: CheckoutMethod.card,
    //   fullscreen: false,
    // );
    //
    // if (response.status == true) {
    //   // Payment successful, handle success
    //   postData();
    //   setState(() {
    //     isLoading = true;
    //     selectedIndex = 4;
    //     _progressValue = 1;
    //     tansactionId = response.reference!;
    //     error = false;
    //     success = true;
    //   });
    // } else {
    //   // Payment failed, handle failure
    //   setState(() {
    //     selectedIndex = 3;
    //     _progressValue = 0.8;
    //     error = true;
    //     success = false;
    //   });
    // }
  }

  // String getPublicKey() {
  //   return "";
  // }

  String getPublicKey() {
    return "FLWPUBK_TEST-338b15d10541846a3fde027c69cbcd71-X";
  }
}
