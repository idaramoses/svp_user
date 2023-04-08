import 'package:flutter/material.dart';

import '../../../../models/main_user.dart';

class AuthProvider extends ChangeNotifier {
  String _token = "";
  User _userInfo = User();
  List<User> _blockedUsers;

  //getter
  String get token => _token;

  User get userInfo => _userInfo;

  List<User> get blockedUsers => _blockedUsers;

  //setter
  set token(String data) {
    if (data != null && data.trim() != "" && data != _token) _token = data;
    notifyListeners();
  }

  set userInfo(dynamic data) {
    Map<String, dynamic> _data = Map<String, dynamic>.from(data);
    _userInfo = User.fromJson(_data);
    notifyListeners();
  }

  set blockedUsers(List<dynamic> data) {
    if (data != null) {
      List<User> _data = [];

      data.forEach((element) {
        _data.add(User.fromJson(Map<String, dynamic>.from(element)));
      });

      _blockedUsers = _data;
      notifyListeners();
    }
  }
}
