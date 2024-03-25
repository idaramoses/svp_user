import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String isIntro = 'intro';
  static String isLogin = 'login';
  static String darkMode = "dark Mode";

  static setIntro(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isIntro, value);
  }

  static Future<bool> getIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isIntro) ?? true;
  }

  static setLogin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLogin, value);
  }

  static cleardate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs?.remove('token');
    await prefs?.remove('location');
    await prefs?.remove('email');
    await prefs?.remove('firstname');
    await prefs?.remove('lastname');
    await prefs?.remove('id');
    await prefs?.remove('phone');
    await prefs?.remove('user');
    await prefs?.clear();
  }

  static deletedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs?.clear();
  }

  static Future<bool> getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLogin) ?? true;
  }

  static setDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(darkMode, value);
  }

  static Future<bool> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(darkMode) ?? false;
  }
}
