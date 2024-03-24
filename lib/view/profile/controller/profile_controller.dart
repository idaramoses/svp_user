import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/service_api.dart';
import '../../../model/user_model.dart';

class UserController extends GetxController {
  var user = UserModel(
    id: '',
    firstname: '',
    lastname: '',
    email: '',
    phone: '',
    location: '',
    meter: '',
    accessToken: '',
  ).obs;

  void setUser(UserModel userData) {
    user.value = userData;
  }
}

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController meterController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpiryController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();
  final addCardFormKey = GlobalKey<FormState>();
  var id = ''.obs;
  var firstname = ''.obs;
  var lastname = ''.obs;
  var address = ''.obs;
  var meter = ''.obs;
  var location = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var accessToken = ''.obs;
  @override
  void onInit() {
    // Fetch user details on initialization
    fetchUserDetails();
    super.onInit();
  }

  void fetchUserDetails() async {
    // Retrieve user details from local storage or any other source
    final userModel = await SuperbaseService().getUserDataFromLocalStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (userModel != null) {
      setUserDetails(
          '${prefs.getString('id')}',
          '${prefs.getString('firstname')}',
          '${prefs.getString('lastname')}',
          '${prefs.getString('email')}',
          '${prefs.getString('phone')}',
          '${prefs.getString('location')}',
          '${prefs.getString('meter')}',
          userModel.accessToken);
    }
  }

  void setUserDetails(
      String newid,
      String newFirstName,
      String newLastName,
      String newEmail,
      String newPhone,
      String newLocation,
      String newMeter,
      String newaccesstoken) {
    id.value = newid;
    firstname.value = newFirstName;
    lastname.value = newLastName;
    email.value = newEmail;
    phone.value = newPhone;
    location.value = newLocation;
    meter.value = newMeter;
    accessToken.value = newaccesstoken;
  }

  void updateUserDetails(String newid, String newFirstName, String newLastName,
      String newEmail, String newPhone) {
    id.value = newid;
    firstname.value = newFirstName;
    lastname.value = newLastName;
    email.value = newEmail;
    phone.value = newPhone;
  }

  void clearText() {
    emailController.clear();
    phoneController.clear();
    firstnameController.clear();
    locationController.clear();
    meterController.clear();
    lastnameController.clear();
    update();
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
