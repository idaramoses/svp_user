import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class SuperbaseService {
  Future<void> saveUserDataToLocalStorage(UserModel userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(userData.toJson()));
  }

  Future<void> deleteUserDataToLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<UserModel?> getUserDataFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user');

    if (userDataString != null) {
      final userDataJson = jsonDecode(userDataString) as Map<String, dynamic>;
      return UserModel.fromJson(userDataJson);
    }

    return null;
  }
}
