import 'package:flutter/material.dart';

import '../../../models/notification.dart';
import '../../../models/post.dart';

class NotificationProvider extends ChangeNotifier {
  List<Notifications> _posts;
  List<Attatment> _attatchment;
  List<Activities> _actiities;

  //get
  List<Notifications> get posts => _posts;
  List<Attatment> get attatchment => _attatchment;
  List<Activities> get actiities => _actiities;



  set posts(List<dynamic> postList) {
    if (postList != null) {
      List<Notifications> _postList = [];

      postList.forEach((dynamic data) {
        _postList.add(
          Notifications.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      });

      _posts = _postList;
      notifyListeners();
    }
  }
  set attatchment(List<dynamic> attatchmentList) {
    if (attatchmentList != null) {
      List<Attatment> _attatchmentList = [];

      attatchmentList.forEach((dynamic data) {
        _attatchmentList.add(
          Attatment.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      });

      _attatchment = _attatchmentList;
      notifyListeners();
    }
  }
  set actiities(List<dynamic> actiitiesList) {
    if (actiitiesList != null) {
      List<Activities> _actiitiesList = [];

      actiitiesList.forEach((dynamic data) {
        _actiitiesList.add(
          Activities.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      });

      _actiities = _actiitiesList;
      notifyListeners();
    }
  }

}
