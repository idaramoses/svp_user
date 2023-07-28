import 'package:flutter/material.dart';

import '../../../models/profile.dart';

class ProfileProvider extends ChangeNotifier {
  String _token = "";
  Profile _userInfo = Profile();
  List<Profile> _blockedUsers;

  //getter
  String get token => _token;

  Profile get userInfo => _userInfo;

  List<Profile> get blockedUsers => _blockedUsers;

  //setter
  set token(String data) {
    if (data != null && data.trim() != "" && data != _token) _token = data;
    notifyListeners();
  }

  set userInfo(dynamic data) {
    Map<String, dynamic> _data = Map<String, dynamic>.from(data);
    _userInfo = Profile.fromJson(_data);
    notifyListeners();
  }
}
