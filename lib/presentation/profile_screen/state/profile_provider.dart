import 'package:flutter/material.dart';

import '../../../models/profile.dart';

class ProfileProvider extends ChangeNotifier {
  Profile _userInfo = Profile();
  //getter
  Profile get userInfo => _userInfo;
  set userInfo(dynamic data) {
    Map<String, dynamic> _data = Map<String, dynamic>.from(data);
    _userInfo = Profile.fromJson(_data);
    notifyListeners();
  }
}
