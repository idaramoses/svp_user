import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../data/service_api.dart';
import '../../../../../main.dart';
import '../../../../../model/user_model.dart';
import '../../../../../res/common/app_button.dart';
import '../../../../../res/common/app_methods.dart';
import '../../../../../res/common/app_textfield.dart';
import '../../../../../res/constant/app_strings.dart';

import '../../../../../utils/themes.dart';
import '../../../../electricity/controller/electricity_controller.dart';
import '../../../controller/profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ElectricityController profileController = Get.put(ElectricityController());
  final ProfileController _profileController = Get.find();
  final SuperbaseService _superbaseService = SuperbaseService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final formKey = GlobalKey<FormState>();
  FocusNode _textFieldFocusNode = FocusNode();
  bool isLoading = false;
  late String selectedState = 'Abia';

  List<String> states = [
    'Abia',
    'Adamawa',
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
    'Lagos',
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
  @override
  void dispose() {
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
                      child:  GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedState = states[index];
                            profileController.locationController.text =
                            states[index];
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

  @override
  Widget build(BuildContext context) {
    const initialCountryCode = 'US';
    var country =
        countries.firstWhere((element) => element.code == initialCountryCode);
    return Scaffold(
      appBar: CommonMethods.appBar(
        onTap: () {
          CommonMethods.jumpOutFromScreen(context);
        },
        backgroundColor: Themes.getScaffoldColor(context),
        title: CommonMethods.appTexts(
          context,
          AppText.editProfile,
          color: Themes.getTextColor(context),
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Divider(
                color: Themes.getDividerColor(context),
              ),
              CommonMethods.sizedBox(height: 10.h),
              Padding(
                padding: CommonMethods.appPadding(),
                child: Column(
                  children: [
                    CommonMethods.imagesOfApp(
                      AppImages.blankProfile,
                      width: 140.h,
                      height: 104.h,
                    ),
                    CommonMethods.sizedBox(height: 38.h),
                    AppTextFieldScreen(
                      controller: profileController.firstnameController,
                      hintText: 'First Name',
                      label: CommonMethods.appTexts(
                        context,
                        'First Name',
                      ),
                      textInputType: TextInputType.name,
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
                      controller: profileController.lastnameController,
                      hintText: 'Last Name',
                      label: CommonMethods.appTexts(
                        context,
                        'Last Name',
                      ),
                      textInputType: TextInputType.name,
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
                    // CommonMethods.sizedBox(height: 24.h),
                    // AppTextFieldScreen(
                    //   controller: profileController.meterController,
                    //   isDense: true,
                    //   hintText: 'Meter Number',
                    //   label: CommonMethods.appTexts(
                    //     context,
                    //     'Meter Number',
                    //   ),
                    //   textInputType: TextInputType.phone,
                    //   keyboardType: TextInputAction.next,
                    //   validator: (val) {
                    //     if (val!.trim().isNotEmpty) {
                    //       if (val.trim().isEmpty) {
                    //         return "This field is required";
                    //       }
                    //       return null;
                    //     }
                    //     return "This field is required";
                    //   },
                    // ),
                    CommonMethods.sizedBox(height: 24.h),
                    AppTextFieldScreen(
                      controller: profileController.phonenumberController,
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
                            return "This field is required";
                          }
                          return null;
                        }
                        return "This field is required";
                      },
                    ),
                    CommonMethods.sizedBox(height: 24.h),
                    AppTextFieldScreen(
                      controller: profileController.locationController,
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
                  ],
                ),
              ),
              CommonMethods.sizedBox(height: 40.h),
              isLoading
                  ? Padding(
                      padding: CommonMethods.appPadding(),
                      child: Container(
                          height: 54.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(64.r),
                            color: Themes.getPrimaryColor(context),
                          ),
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          ))),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          postData();
                        }
                      },
                      child: Padding(
                        padding: CommonMethods.appPadding(),
                        child: const AppButton(
                          text: 'Save details',
                        ),
                      ),
                    ),
              CommonMethods.sizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> postData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userModel = await SuperbaseService().getUserDataFromLocalStorage();
    var url = Uri.parse('https://sparkhub.ng/api/profile/bash');
    String token = '${prefs.getString('token')}';
    final currentUser = supabase.auth.currentUser;
    print('token: ${prefs.getString('token')}');
    print('token: ${userModel?.accessToken}');

    setState(() {
      isLoading = true;
    });
    try {
      // Get the current authenticated user
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw 'No user is currently signed in.';
      }

      // Prepare the attributes to update
      final attributes = UserAttributes(
          // Update with the attributes you want to change
          data: {
            "firstname": "${profileController.firstnameController.text}",
            "lastname": "${profileController.lastnameController.text}",
            // "meter": "${profileController.meterController.text}",
            "phone": "${profileController.phonenumberController.text}",
            "location": "${profileController.locationController.text}",
          }
          // Add more attributes as needed
          );

      // Update user data
      final response = await supabase.auth.updateUser(attributes);
      supabase.auth.onAuthStateChange.listen((data) async {
        final AuthChangeEvent event = data.event;
        User? user = Supabase.instance.client.auth.currentUser;
        // Now you can access user data like user.id, user.email, etc.
        // For example:
        Map<String, dynamic>? metadata = user?.userMetadata;
        final userModel = UserModel.fromJson(metadata!);
        final SharedPreferences prefs = await _prefs;
        // await prefs?.setString(
        //     'token', '$accessToken');
        await prefs?.setString('location', '${metadata['location']}');
        await prefs?.setString('email', '${user?.email}');
        await prefs?.setString('firstname', '${metadata['firstname']}');
        await prefs?.setString('lastname', '${metadata['lastname']}');
        await prefs?.setString('id', '${user?.id}');
        await prefs?.setString('phone', '${metadata['phone']}');
        // Save user data to SharedPreferences
        await _superbaseService.saveUserDataToLocalStorage(userModel);
        // Set user data for the profile screen
        _profileController.setUserDetails(
          userModel.id,
          userModel.firstname,
          userModel.lastname,
          userModel.email,
          userModel.phone,
          userModel.location,
          userModel.meter,
          userModel.accessToken,
        );
      });
      // Handle successful update
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print('Error updating user data: $error');
      Get.snackbar(
        'Error',
        '${error}}',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      );
      setState(() {
        isLoading = false;
      });
      // Handle error, show message to the user, etc.
    }
    // Your JSON data
    // var data = {
    //   "firstname": "${profileController.firstnameController.text}",
    //   "lastname": "${profileController.lastnameController.text}",
    //   "meter": "${profileController.meterController.text}",
    //   "phone": "${profileController.phonenumberController.text}",
    //   "location": "${profileController.locationController.text}",
    // };
    setState(() {
      isLoading = false;
    });
  }
}
