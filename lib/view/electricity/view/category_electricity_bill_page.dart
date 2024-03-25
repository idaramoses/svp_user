import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../res/common/app_button.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/common/app_textfield.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../utils/themes.dart';
import '../controller/electricity_controller.dart';

class StateModel {
  final int id;
  final String name;

  StateModel(this.id, this.name);
}

class CategoryElectricityBillPage extends StatefulWidget {
  final List<String> regions;

  CategoryElectricityBillPage({required this.regions});

  @override
  State<CategoryElectricityBillPage> createState() =>
      _CategoryElectricityBillPageState();
}

class _CategoryElectricityBillPageState
    extends State<CategoryElectricityBillPage> {
  ElectricityController electricityController =
      Get.put(ElectricityController());
  int selectedIndex = 0;
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
  String message = '';
  List<String> pinCode = List.filled(4, '');
  List<String> firstpinCode = List.filled(4, '');
  List<String> secondpinCode = List.filled(4, '');
  bool isverification = false;
  bool iscorrect = false;
  bool isfail = false;
  bool isnull = true;
  bool isfirstpin = false;
  bool issecondpin = false;
  bool isauth = false;
  bool incorrectpin = false;
  late String name;
  late String pincodevalue;
  bool isTestMode = true;
  bool error = false;
  bool success = true;
  bool ispaying = false;

  String publicKey = 'pk_test_1ff1aaf622e69101eab8cae0b894e188b638d0fa';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    _loadTextFieldValue();
    plugin.initialize(publicKey: publicKey);
    print('regions: ${widget.regions}');
  }

  Map<String, dynamic> rowData = {
    'token': '',
    'status': '',
    'meter': '',
    'transaction_id': '',
    'commission': '',
    'amount_paid': '',
    'service_provider': '',
    'amount': '',
    'request_id': '',
    'customer_name': '',
    'address': '',
    'units': '',
    'user_id': '',
    'name': '',
    'email': '',
    'phone_number': '',
  };
  Future<void> _loadTextFieldValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String textFieldValue = prefs.getString('firstname') ?? '';
    String pincodeValue = prefs.getString('pincode') ?? '';
    setState(() {
      name = textFieldValue;
      pincodevalue = pincodeValue;
    });
  }

  void onNumberPressed(String number) {
    bool updated = false;
    for (int i = 0; i < pinCode.length; i++) {
      if (pinCode[i].isEmpty && !updated) {
        setState(() {
          pinCode[i] = number;
          updated = true;
          if (i == 3) {
            // Check if PIN code is complete
            String enteredPin =
                pinCode.join(); // Combine PIN digits into a string
            if (enteredPin == pincodevalue) {
              // Navigate to home page if PIN code is correct
              setState(() {
                iscorrect = true;
                isfail = false;
                isnull = true;
              });
              Future.delayed(Duration(seconds: 1), () {
                makePayment();
                isverification = false;
              });
            } else {
              // Reset PIN code if incorrect
              setState(() {
                iscorrect = false;
                isfail = true;
                isnull = false;
              });
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  pinCode.fillRange(0, 4, '');
                  isnull = true;
                  iscorrect = false;
                  isfail = false;
                  isnull = true;
                });
              });
              Get.snackbar(
                'Error',
                'Incorrect pin',
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              );
            }
          }
        });
      }
    }
  }

  void onBackspacePressed() {
    for (int i = pinCode.length - 1; i >= 0; i--) {
      if (pinCode[i].isNotEmpty) {
        setState(() {
          pinCode[i] = '';
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Get.toNamed(RoutesPath.bottomBarPage);
          return true;
        },
        child: Scaffold(
          appBar: CommonMethods.appBar(
              onTap: () {
                // CommonMethods.jumpOutFromScreen(context);
                Get.toNamed(RoutesPath.bottomBarPage);
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
          body: Stack(
            children: [
              Column(
                children: [
                  CommonMethods.sizedBox(height: 16.h),
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
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: widget.regions.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state =
                                                          '${widget.regions[index]}';
                                                      isLoading = true;
                                                    });
                                                    selectstate(
                                                        '${widget.regions[index]}');
                                                    // postData();
                                                  },
                                                  child: Container(
                                                    height: 54.h,
                                                    decoration: CommonMethods
                                                        .getBoxDecoration(
                                                      cornerRadius: 20.r,
                                                      color:
                                                          Themes.getCardColor(
                                                              context),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 16.w,
                                                        right: 17.71.w,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: CommonMethods
                                                                .appTexts(
                                                              context,
                                                              '${widget.regions[index]}',
                                                              color: Themes
                                                                  .getTextColor(
                                                                      context),
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_sharp,
                                                            size: 20.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                CommonMethods.sizedBox(
                                                    height: 16.h)
                                              ],
                                            );
                                          },
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
                                      placeholderBuilder:
                                          (BuildContext context) => Container(
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
                                    controller:
                                        electricityController.meterController,
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
                                            items: <String>[
                                              'Prepaid',
                                              'Postpaid'
                                            ].map<DropdownMenuItem<String>>(
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
                                            if (formKey.currentState!
                                                .validate()) {
                                              debugPrint("Success");
                                              setState(() {
                                                isLoading = true;
                                              });
                                              final url = Uri.parse(
                                                  'https://www.sparkhub.ng/api/meters/verify?meter=${electricityController.meterController.text}&location=${state}&type=${selectedValue}');
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

                                                if (response.statusCode ==
                                                    200) {
                                                  // Request was successful
                                                  print(
                                                      'Response: ${response.body}');
                                                  final decodedData = json
                                                      .decode(response.body);
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
                                                    snackPosition:
                                                        SnackPosition.TOP,
                                                    colorText: Colors.white,
                                                    backgroundColor: Colors.red,
                                                    duration:
                                                        Duration(seconds: 1),
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
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  colorText: Colors.white,
                                                  backgroundColor: Colors.red,
                                                  duration:
                                                      Duration(seconds: 1),
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
                                          color:
                                              Themes.getPrimaryColor(context),
                                        ),
                                        label: Text(
                                          'Previous',
                                          style: TextStyle(
                                            color:
                                                Themes.getPrimaryColor(context),
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
                                          setState(() {
                                            isLoading = true;
                                            isverification = true;
                                          });
                                          FocusScope.of(context).unfocus();
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
                                          color:
                                              Themes.getPrimaryColor(context),
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
                                            width: 120
                                                .h, // Adjust the size as needed
                                            height: 120
                                                .h, // Adjust the size as needed
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
                                              color:
                                                  Themes.getTextColor(context),
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
                                                color: Themes.getTextColor(
                                                    context),
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
                                              makePayment();
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
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 20, 0, 10),
                                              child: Center(
                                                child: Text(
                                                  "Restart payment",
                                                  style: TextStyle(
                                                    color:
                                                        Themes.getPrimaryColor(
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
                                          color:
                                              Themes.getPrimaryColor(context),
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
                                        width:
                                            120.h, // Adjust the size as needed
                                        height:
                                            120.h, // Adjust the size as needed
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
                                                color: Themes.getPrimaryColor(
                                                    context),
                                              ),
                                              child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: Colors.white,
                                              )))
                                          : GestureDetector(
                                              onTap: () async {
                                                CommonMethods
                                                    .sendToNextScreenWithoutBack(
                                                        context,
                                                        RoutesPath
                                                            .paymentTransactionDetailPage,
                                                        arguments: {
                                                      'id': '${rowData['id']}',
                                                      'transaction_id':
                                                          '${rowData['transaction_id']}',
                                                      'amount':
                                                          '${rowData['amount']}',
                                                      'status':
                                                          '${rowData['status']}',
                                                      'email':
                                                          '${rowData['email']}',
                                                      'created_at':
                                                          '${rowData['created_at']}',
                                                      'phone_number':
                                                          '${rowData['phone_number']}',
                                                      'meter':
                                                          '${rowData['meter']}',
                                                      'customer_name':
                                                          '${rowData['customer_name']}',
                                                      'address':
                                                          '${rowData['address']}',
                                                      'token':
                                                          '${rowData['token']}',
                                                      'service_provider':
                                                          '${rowData['service_provider']}',
                                                    });
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
              isverification
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      color: Themes.getScaffoldColor(context),
                      child: ListView(
                        children: [
                          CommonMethods.sizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    isverification = false;
                                    isLoading = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                label: Text(
                                  'Close',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CommonMethods.sizedBox(height: 10.h),
                          CommonMethods.appTexts(context, 'Enter your  pin',
                              color: Themes.getTextColor(context),
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.center),
                          CommonMethods.sizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < pinCode.length; i++)
                                Container(
                                  width: 50,
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: isfail
                                            ? Colors.red
                                            : iscorrect
                                                ? Colors.green
                                                : Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    pinCode[i],
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Themes.getTextColor(context)),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 20),
                          GridView.count(
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            children: List.generate(
                              10,
                              (index) => Container(
                                padding: EdgeInsets.all(
                                    20), // Adjust padding as needed
                                child: SizedBox(
                                  child: TextButton(
                                    onPressed: () =>
                                        onNumberPressed(index.toString()),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey.withOpacity(0.1)),
                                      side:
                                          MaterialStateProperty.all(BorderSide(
                                        color: Colors.grey
                                            .withOpacity(0.2), // Border color
                                        width: 1.0, // Border width
                                      )),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              50.0), // Border radius
                                        ),
                                      ),
                                    ),
                                    child: Text(index.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color:
                                              Themes.getPrimaryColor(context),
                                        )), // Adjust font size as needed
                                  ),
                                ),
                              ),
                            )..add(
                                Container(
                                  padding: EdgeInsets.all(
                                      20), // Adjust padding as needed
                                  child: SizedBox(
                                    child: TextButton(
                                      onPressed: onBackspacePressed,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey.withOpacity(0.1)),
                                        side: MaterialStateProperty.all(
                                            BorderSide(
                                          color: Colors.grey
                                              .withOpacity(0.2), // Border color
                                          width: 1.0, // Border width
                                        )),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                50.0), // Border radius
                                          ),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.backspace,
                                        size: 24,
                                        color: Themes.getPrimaryColor(context),
                                      ), // Adjust icon size as needed
                                    ),
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectstate(String s) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('https://www.sparkhub.ng/api/states/${state}');

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
    var url = Uri.parse('https://www.sparkhub.ng/api/pay');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = '${prefs.getString('email')}' ?? "";
    String phone = '${prefs.getString('phone')}' ?? "";
    String user_id = '${prefs.getString('id')}' ?? "";
    String name = '${prefs.getString('firstname')}' ?? "";
    // Your JSON data
    var data = {
      "location": "$state",
      "meter": "${electricityController.meterController.text}",
      "type": "${Meter_Type.toLowerCase()}",
      "amount": "${electricityController.amount.text}",
      "phone": "$phone",

      // "location": "akwaibom",
      // "meter": "1111111111111",
      // "type": "prepaid",
      // "amount": "2000",
      // "phone": "08108402170"

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
        print('true');
        // If the server returns a 200 OK response,
        // parse the JSON response
        var jsonResponse = jsonDecode(response.body);
        print('token: ${jsonResponse['token']}');
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
          'user_id': "$user_id",
          'name': "$name",
          'email': "$email",
          'phone_number': "$phone",
          'txref': '$tx_ref',
        }).execute();
        Map<String, dynamic> trnasResponse = {
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
          'user_id': "$user_id",
          'name': "$name",
          'email': "$email",
          'phone_number': "$phone",
          'txref': '$tx_ref',
        };

        // Update the UI with data from the JSON response

        setState(() {
          token = '${jsonResponse['token']}';
          isLoading = false;
          rowData = trnasResponse;
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

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: '4084084084084081',
      cvc: '408',
      expiryMonth: 1,
      expiryYear: 25,
    );
  }

  void makePayment() async {
    setState(() {
      ispaying = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = '${prefs.getString('email')}';
    int price = int.parse("${electricityController.amount.text}") * 100;
    Charge charge = Charge();
    charge.card = _getCardFromUI();
    charge
      ..amount = price
      ..reference = 'ref_${DateTime.now()}'
      ..email = "$email"
      ..currency = 'NGN';

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      fullscreen: false,
      charge: charge,
    );
    if (response.status == true) {
      // Payment successful, handle success
      postData();
      setState(() {
        isLoading = true;
        selectedIndex = 4;
        _progressValue = 1;
        ispaying = false;
        tx_ref = response.reference!;
        error = false;
        success = true;
      });
    } else {
      // Payment failed, handle failure
      setState(() {
        selectedIndex = 3;
        _progressValue = 0.8;
        ispaying = false;
        error = true;
        success = false;
      });
    }
  }

  _handlePaymentInitializationn() async {
    // await FlutterPaystackPlus.openPaystackPopup(
    //     publicKey: 'pk_test_38b65853b5f5045e895bd1f996a28c5a12412f6a',
    //     context: context,
    //     secretKey: "sk_test_25200f962c235342a1a2d8ddc79cf91c1199b7a0",
    //     currency: 'NGN',
    //     customerEmail: "${electricityController.emailController.text}",
    //     amount: "20000",
    //     reference: DateTime.now().microsecondsSinceEpoch.toString(),
    //     onClosed: () {
    //       debugPrint('Could\'nt finish payment');
    //     },
    //     onSuccess: () {
    //       debugPrint('Payment successful');
    //     });
  }

  var banks = ['Selectable', 'Bank', 'Card'];

  // String getPublicKey() {
  //   return "";
  // }

  String getPublicKey() {
    return "FLWPUBK_TEST-338b15d10541846a3fde027c69cbcd71-X";
  }
}
