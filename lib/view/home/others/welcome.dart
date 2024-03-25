import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sharkhub/view/home/controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/service_api.dart';
import '../../../main.dart';
import '../../../model/user_model.dart';
import '../../../res/common/app_button.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/common/app_textfield.dart';
import '../../../res/constant/app_routes_path.dart';

import '../../../utils/themes.dart';
import '../../profile/controller/profile_controller.dart';

class WelcomeDialog extends StatefulWidget {
  @override
  _WelcomeDialogState createState() => _WelcomeDialogState();
}

class _WelcomeDialogState extends State<WelcomeDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController meterController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController prepaidController = TextEditingController();
  final SuperbaseService _superbaseService = SuperbaseService();
  final ProfileController _profileController = Get.find();
  // final HomeController _HomeController = Get.find();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final HomeController _HomeController = Get.put(HomeController());
  Timer? _timer;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  FocusNode _textFieldFocusNode = FocusNode();
  late String selectedState = 'Abia';

  List<String> states = [
    'Abia',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos-Ikeja',
    'Lagos-Eko',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
    'FCT-Abuja',
  ];
  late String selectedPrepaid = 'Prepaid';

  List<String> prepaid = [
    'Prepaid',
    'Postpaid',
  ];
  @override
  void initState() {
    super.initState();
    checkGenderAndShowDialog(context);
  }

  bool iswelcome = false;
  Future<void> checkGenderAndShowDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? gender = prefs.getString('welcome');

    if (gender == null || gender.isEmpty) {
      setState(() {
        iswelcome = true;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textFieldFocusNode
        .dispose(); // Dispose of the FocusNode to prevent memory leaks
    super.dispose();
  }

  void _showStatePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Themes.getScaffoldColor(context),
          child: Column(
            children: [
              CommonMethods.sizedBox(height: 20.h),
              CommonMethods.appTexts(
                context,
                'Select state',
                color: Themes.getPrimaryColor(context),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              CommonMethods.sizedBox(height: 10.h),
              Divider(),
              CommonMethods.sizedBox(height: 10.h),
              Expanded(
                child: ListView.builder(
                  itemCount: states.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedState = states[index];
                            locationController.text = states[index];
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 60.h,
                          decoration: CommonMethods.getBoxDecoration(
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      CommonMethods.appTexts(
                                        context,
                                        states[index].toString(),
                                        color:
                                        Themes.getTextColor(context),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      CommonMethods.sizedBox(height: 5.h),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPrepaidPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Themes.getScaffoldColor(context),
          child: Column(
            children: [
              CommonMethods.sizedBox(height: 20.h),
              CommonMethods.appTexts(
                context,
                'Select meter type',
                color: Themes.getPrimaryColor(context),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              CommonMethods.sizedBox(height: 10.h),
              Divider(),
              CommonMethods.sizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: prepaid.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedState = prepaid[index];
                            prepaidController.text = prepaid[index];
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 60.h,
                          decoration: CommonMethods.getBoxDecoration(
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      CommonMethods.appTexts(
                                        context,
                                        prepaid[index].toString(),
                                        color:
                                        Themes.getTextColor(context),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      CommonMethods.sizedBox(height: 5.h),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return  WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesPath.finishbottomBarPage);
        return false;
      },
      child: Scaffold(
          appBar: CommonMethods.appBar(
              onTap: () {
                // CommonMethods.jumpOutFromScreen(context);
                Get.toNamed(RoutesPath.finishbottomBarPage);
              },
              backgroundColor: Themes.getScaffoldColor(context),
              title: CommonMethods.appTexts(
                context,
                'Add Meter Number',
                color: Themes.getTextColor(context),
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
              actions: []),

        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          child: Form(
            key: formKey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonMethods.appTexts(
                    context,
                    iswelcome
                        ? 'Enter the details below to continue'
                        : 'Enter the details below to add new meter',
                    color: Themes.getTextColor(context),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CommonMethods.sizedBox(height: 28.h),
                  AppTextFieldScreen(
                    controller: meterController,
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
                          return "This field is required";
                        }
                        return null;
                      }
                      return "This field is required";
                    },
                  ),
                  CommonMethods.sizedBox(height: 24.h),
                  AppTextFieldScreen(
                    controller: locationController,
                    focusNode: _textFieldFocusNode,
                    isDense: true,
                    readOnly: true,
                    hintText: 'Select location',
                    label: CommonMethods.appTexts(
                      context,
                      'Select location',
                    ),
                    textInputType: TextInputType.phone,
                    keyboardType: TextInputAction.next,
                    suffixIcon: Icon(Icons.arrow_drop_down,
                        color: Themes.getTextColor(context)),
                    onTap: _showStatePicker,
                  ),
                  CommonMethods.sizedBox(height: 24.h),
                  AppTextFieldScreen(
                    controller: prepaidController,
                    focusNode: _textFieldFocusNode,
                    isDense: true,
                    readOnly: true,
                    hintText: 'Select meter type',
                    label: CommonMethods.appTexts(
                      context,
                      'Select meter type',
                    ),
                    textInputType: TextInputType.phone,
                    keyboardType: TextInputAction.next,
                    suffixIcon: Icon(Icons.arrow_drop_down,
                        color: Themes.getTextColor(context)),
                    onTap: _showPrepaidPicker,
                  ),
                  CommonMethods.sizedBox(height: 40.h),
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
                        String state = locationController.text
                            .toLowerCase()
                            .replaceAll(' ', '');
                        setState(() {
                          isLoading = true;
                        });
                        final url = Uri.parse(
                            'https://www.sparkhub.ng/api/meters/verify?meter=${meterController.text}&location=${state.toLowerCase().replaceAll(' ', '')}&type=${prepaidController.text}');
                        try {
                          final response = await http.get(
                            url,
                            headers: {
                              'Content-Type': 'application/json',
                            },
                          );

                          if (response.statusCode == 200) {
                            // Request was successful
                            postData();
                          } else {
                            Get.snackbar(
                              'Error',
                              'Invalid meter number',
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            );
                            print('error: ${response.body}');
                            setState(() {
                              isLoading = false;
                            });
                          }
                        } catch (e) {
                          // Handle exceptions
                          Get.snackbar(
                            'Error',
                            '$e',
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
                      text: 'Save details',
                    ),
                  ),
                  CommonMethods.sizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  Future<void> postData() async {
    String state = locationController.text.toLowerCase().replaceAll(' ', '');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = Uri.parse('https://sparkhub.ng/api/profile/bash');
    String phone = '${prefs.getString('phone')}';
    final currentUser = supabase.auth.currentUser;
    print('token: ${prefs.getString('token')}');

    setState(() {
      isLoading = true;
    });

    await prefs?.setString('welcome', 'yes');
    print('add metter ----------------------------------------------------------------------');
    String id = '${prefs.getString('id')}';
    Get.snackbar(
      'Success',
      'Meter added',
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
    );
    await supabase.from('meters').insert({
      'type': "${prepaidController.text}",
      'meter': "${meterController.text}",
      'location': "$state",
      'name': "Default Meter",
      'phone': '${phone}',
      'user_id': '${id}',
    }).execute();

    Get.toNamed(RoutesPath.finishbottomBarPage);
    setState(() {
      isLoading = false;
    });


  }
}
