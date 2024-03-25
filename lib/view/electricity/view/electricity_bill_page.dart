import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../main.dart';
import '../../../res/common/app_button.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/common/app_textfield.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import '../../home/controller/home_controller.dart';
import '../../home/others/categories.dart';
import '../../home/others/welcome.dart';
import '../controller/electricity_controller.dart';

class StateModel {
  final int id;
  final String name;

  StateModel(this.id, this.name);
}

class ElectricityBillPage extends StatefulWidget {
  const ElectricityBillPage({super.key});

  @override
  State<ElectricityBillPage> createState() => _ElectricityBillPageState();
}

class _ElectricityBillPageState extends State<ElectricityBillPage> with WidgetsBindingObserver {
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
  List<ElectricityCompany> electricityCompanies = [
    ElectricityCompany(
      name: "Ikeja",
      alias: "IKEDC",
      image: 'assets/svg/ikeja.png',
      regions: ["lagos-ikeja"],
    ),
    // Add other ElectricityCompany objects here
  ];
  ElectricityController electricityController =
  Get.put(ElectricityController());
  HomeController homeController = Get.put(HomeController());
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

  bool isTestMode = true;
  bool error = false;
  bool success = true;
  bool ispaying = false;

  String publicKey = 'pk_test_1ff1aaf622e69101eab8cae0b894e188b638d0fa';
  final plugin = PaystackPlugin();
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
  @override
  void initState() {
    super.initState();
    _loadTextFieldValue();
    plugin.initialize(publicKey: publicKey);
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // homeController.fetchMeterData();
      print("Resume data");
    });
    print("Resume");
  }
  Future<void> _loadTextFieldValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String textFieldValue = prefs.getString('firstname') ?? '';
    String pincodeValue = prefs.getString('pincode') ?? '';
    setState(() {
      name = textFieldValue;
      pincodevalue = pincodeValue;
    });
  }

  String getImagePathForRegion(String region) {
    for (var company in companies) {
      if (company.regions.contains(region.toLowerCase())) {
        return company.image;
      }
    }
    // Return a default image path if the region is not found
    return 'assets/default_image.png'; // Provide the path to your default image
  }

  String getAlliasPathForRegion(String region) {
    for (var company in companies) {
      if (company.regions.contains(region.toLowerCase())) {
        return company.alias;
      }
    }
    // Return a default image path if the region is not found
    return 'PHED'; // Provide the path to your default image
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                CommonMethods.sizedBox(height: 16.h),
                selectedIndex == 0
                    ? Padding(
                  padding: CommonMethods.appPadding(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonMethods.appTexts(
                          context,
                          "Select meter",
                          color: Themes.getTextColor(context),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        CommonMethods.sizedBox(height: 16.h),
                        Divider(
                          color: Themes.getDividerColor(context),
                        ),
                        CommonMethods.sizedBox(height: 16.h),
                        Obx(() {
                          if (homeController.isLoading.value) {
                            return Container(
                                height: 200.h,
                                width: double.infinity,
                                child: Shimmer.fromColors(
                                  baseColor: Themes.getCardColor(context)
                                      .withOpacity(0.7),
                                  highlightColor:
                                  Themes.getPrimaryColor(context)
                                      .withOpacity(0.2),
                                  child: ListView.builder(
                                    itemCount:
                                    4, // Number of shimmering items
                                    itemBuilder: (_, __) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 80.h,
                                        decoration:
                                        CommonMethods.getBoxDecoration(
                                          cornerRadius: 20.r,
                                          color: Themes.getPrimaryColor(
                                              context)
                                              .withOpacity(0.3),
                                        ),
                                        child: ListTile(
                                          title: Container(
                                            height: 30.h,
                                            color: Themes.getPrimaryColor(
                                                context)
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
                          } else if (homeController.meters.isNotEmpty) {
                            return Column(
                              children: [
                                Column(
                                  children:
                                  homeController.meters.map((rowData) {
                                    return animationFunction(
                                        1,
                                        slideDuration: Duration(seconds: 1),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                image = getImagePathForRegion(
                                                    rowData[
                                                    'location']);
                                                companyName =
                                                    getAlliasPathForRegion(
                                                        rowData[
                                                        'location']);
                                                selectedIndex = 1;
                                                _progressValue =
                                                0.4;
                                                Meter_Type =
                                                rowData['type'];
                                                MeterNumber =
                                                rowData[
                                                'meter'];
                                                state = rowData[
                                                'location'];
                                                isLoading = false;
                                              });
                                            },
                                            child: Container(
                                              height: 80.h,
                                              decoration: CommonMethods
                                                  .getBoxDecoration(
                                                cornerRadius: 20.r,
                                                color: Themes
                                                    .getCardColor(
                                                    context),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsets.only(
                                                  left: 16.w,
                                                  right: 17.71.w,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 50.h,
                                                      height: 50.h,
                                                      color: Colors
                                                          .white,
                                                      child: CommonMethods
                                                          .imagesOfApp(
                                                        getImagePathForRegion(
                                                            rowData[
                                                            'location']),
                                                        width: 50.h,
                                                        height:
                                                        50.h,
                                                      ),
                                                    ),
                                                    CommonMethods
                                                        .sizedBox(
                                                        width: 12
                                                            .w),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          CommonMethods
                                                              .appTexts(
                                                            context,
                                                            rowData['meter']
                                                                .toString(),
                                                            color: Themes.getTextColor(
                                                                context),
                                                            fontSize:
                                                            16.sp,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                          CommonMethods.sizedBox(
                                                              height:
                                                              5.h),
                                                          CommonMethods
                                                              .appTexts(
                                                            context,
                                                            getAlliasPathForRegion(
                                                                rowData['location']),
                                                            color: Themes.getTextColor(
                                                                context),
                                                            fontSize:
                                                            14.sp,
                                                            fontWeight:
                                                            FontWeight.w300,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Icon(Icons.arrow_forward_ios_sharp,size: 20.h,),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                  }).toList(),
                                ),
                                CommonMethods.sizedBox(height: 16.h),
                                Divider(
                                  color: Themes.getDividerColor(context),
                                ),
                                CommonMethods.sizedBox(height: 16.h),
                                ListTile(
                                  leading: Container(
                                    width: 25.h, // Set width
                                    height: 25.h, // Set height
                                    decoration: BoxDecoration(
                                      color: Themes.getPrimaryColor(
                                          context), // Set background color
                                      shape: BoxShape
                                          .circle, // Set shape to circle
                                    ),
                                    child: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                  onTap: () {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return WelcomeDialog();
                                    //   },
                                    // );

                                    CommonMethods.sendToNextScreen(
                                        context, RoutesPath.AddMeterPage);
                                  },
                                  title: Text(
                                    'Add a new meter',
                                    style: TextStyle(
                                      color:
                                      Themes.getPrimaryColor(context),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Container(
                                    width: 25.h, // Set width
                                    height: 25.h, // Set height
                                    decoration: BoxDecoration(
                                      color: Themes.getPrimaryColor(
                                          context), // Set background color
                                      shape: BoxShape
                                          .circle, // Set shape to circle
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                  onTap: () {
                                    CommonMethods.sendToNextScreen(
                                        context, RoutesPath.AddMeterPage);
                                  },
                                  title: Text(
                                    'Add a new meter',
                                    style: TextStyle(
                                      color:
                                      Themes.getPrimaryColor(context),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
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
                            leading: Container(
                              width: 50.h,
                              height: 50.h,
                              color: Colors.white,
                              child: CommonMethods.imagesOfApp(
                                '$image',
                                width: 50.h,
                                height: 50.h,
                              ),
                            ),
                            title: Text(
                              '$companyName'.toUpperCase(),
                              style: TextStyle(
                                  color: Themes.getTextColor(context),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          CommonMethods.sizedBox(height: 10.h),
                          Divider(
                            color: Themes.getDividerColor(context),
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
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                  isverification = true;
                                });
                                FocusScope.of(context).unfocus();
                              }
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
                            makePayment();
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
                              width:
                              120.h, // Adjust the size as needed
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
                                  color:
                                  Themes.getTextColor(context),
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
                        CommonMethods.imagesOfApp(
                            AppImages.check_image,
                            fit: BoxFit.contain,
                            width: 150.h,
                            height: 150.h),
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
                                child: CircularProgressIndicator(
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
                        padding: EdgeInsets.all(20), // Adjust padding as needed
                        child: SizedBox(

                          child: TextButton(
                            onPressed: () => onNumberPressed(index.toString()),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                              side: MaterialStateProperty.all(BorderSide(
                                color: Colors.grey.withOpacity(0.2), // Border color
                                width: 1.0,          // Border width
                              )),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0), // Border radius
                                ),
                              ),
                            ),
                            child: Text(index.toString(), style: TextStyle(  fontWeight: FontWeight.bold,fontSize: 20, color: Themes.getPrimaryColor(context),)), // Adjust font size as needed
                          ),
                        ),
                      ),
                    )..add(
                      Container(
                        padding: EdgeInsets.all(20), // Adjust padding as needed
                        child: SizedBox(
                          child: TextButton(
                            onPressed: onBackspacePressed,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                              side: MaterialStateProperty.all(BorderSide(
                                color: Colors.grey.withOpacity(0.2), // Border color
                                width: 1.0,          // Border width
                              )),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0), // Border radius
                                ),
                              ),
                            ),
                            child: Icon(Icons.backspace, size: 24, color: Themes.getPrimaryColor(context),), // Adjust icon size as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )  : Container(),
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
    var url = Uri.parse('https://www.sparkhub.ng/api/pay');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = '${prefs.getString('email')}' ?? "";
    String phone = '${prefs.getString('phone')}' ?? "";
    String user_id = '${prefs.getString('id')}' ?? "";
    String name = '${prefs.getString('firstname')}' ?? "";
    // Your JSON data
    var data = {
      "location": "$state",
      "meter": "$MeterNumber",
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

  var banks = ['Selectable', 'Bank', 'Card'];

  // String getPublicKey() {
  //   return "";
  // }

  String getPublicKey() {
    return "FLWPUBK_TEST-338b15d10541846a3fde027c69cbcd71-X";
  }
}
