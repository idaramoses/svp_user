import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/service_api.dart';
import '../../../main.dart';
import '../view/electricity_bill_page.dart';

class ElectricityController extends GetxController {
  // TextEditingController accountNameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController meterController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController amount = TextEditingController();
  String user_id = '';
  String name = '';

  final List<StateModel> allStates = [
    StateModel(1, 'Abia'),
    StateModel(3, 'Akwa Ibom'),
    StateModel(4, 'Anambra'),
    StateModel(5, 'Bauchi'),
    StateModel(6, 'Bayelsa'),
    StateModel(7, 'Benue'),
    StateModel(8, 'Borno'),
    StateModel(9, 'Cross River'),
    StateModel(10, 'Delta'),
    StateModel(11, 'Ebonyi'),
    StateModel(12, 'Edo'),
    StateModel(13, 'Ekiti'),
    StateModel(14, 'Enugu'),
    StateModel(15, 'Gombe'),
    StateModel(16, 'Imo'),
    StateModel(17, 'Jigawa'),
    StateModel(18, 'Kaduna'),
    StateModel(19, 'Kano'),
    StateModel(20, 'Katsina'),
    StateModel(21, 'Kebbi'),
    StateModel(22, 'Kogi'),
    StateModel(23, 'Kwara'),
    StateModel(24, 'Lagos-Ikeja'),
    StateModel(25, 'Lagos-Eko'),
    StateModel(26, 'Nasarawa'),
    StateModel(27, 'Niger'),
    StateModel(28, 'Ogun'),
    StateModel(29, 'Ondo'),
    StateModel(30, 'Osun'),
    StateModel(31, 'Oyo'),
    StateModel(32, 'Plateau'),
    StateModel(33, 'Rivers'),
    StateModel(34, 'Sokoto'),
    StateModel(35, 'Taraba'),
    StateModel(36, 'Yobe'),
    StateModel(37, 'Zamfara'),
    StateModel(38, 'FCT-Abuja'),
  ];

  RxList<StateModel> displayedStates = RxList<StateModel>();
  var meterData = <Map<String, dynamic>>[].obs;
  final transaction = [].obs;
  final recenttransaction = [].obs;
  final meters = [].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    displayedStates.assignAll(allStates);
    print("Initializing ElectricityController"); // Add this line
    fetchUserDetails();
    fetchMeterData();
    print("fetching meters data ----------------------------");
  }

  Future<void> fetchMeterData() async {
    try {
      isLoading(true);
      print('loading');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = '${prefs.getString('id')}';
      // Query the user table for data associated with the authenticated user
      final response = await supabase
          .from('meters')
          .select()
          .eq('user_id', id)
          .order('created_at', ascending: false)
          .limit(4)
          .execute();
      // Update user data
      meters.assignAll(response.data);
      isLoading(false);
      print('finish loading');
    } catch (e) {
      // Handle errors
      print('Error fetching user data: $e');
      isLoading(false);
    }
  }

  void fetchUserDetails() async {
    // Retrieve user details from local storage or any other source
    final userModel = await SuperbaseService().getUserDataFromLocalStorage();

    if (userModel != null) {
      emailController.text = userModel.email;
      firstnameController.text = userModel.firstname;
      lastnameController.text = userModel.lastname;
      phonenumberController.text = userModel.phone;
      meterController.text = userModel.meter;
      locationController.text = userModel.location;
      user_id = userModel.id;
      name = '${userModel.firstname} ${userModel.lastname}';
    }
  }

  void searchStates(String query) {
    query = query.toLowerCase();
    displayedStates.assignAll(
      allStates.where((state) => state.name.toLowerCase().contains(query)),
    );
  }

  void clearText() {
    emailController.clear();
    phonenumberController.clear();
    firstnameController.clear();
    locationController.clear();
    meterController.clear();
    lastnameController.clear();
    update();
  }
}
