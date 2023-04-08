import 'package:flutter/material.dart';

import '../../../models/tasks.dart';

class TasksProvider extends ChangeNotifier {
  List<Tasks> _Taskss;
  List<Tasks> _posts;

  //get

  List<Tasks> get Taskss => _Taskss;

  List<Tasks> get posts => _posts;

  set Taskss(List<dynamic> TasksList) {
    if (TasksList != null) {
      List<Tasks> _TasksList = [];

      TasksList.forEach((dynamic data) {
        _TasksList.add(
          Tasks.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      });

      _Taskss = _TasksList;
      notifyListeners();
    }
  }

  set posts(List<dynamic> postList) {
    if (postList != null) {
      List<Tasks> _postList = [];

      postList.forEach((dynamic data) {
        _postList.add(
          Tasks.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      });

      _posts = _postList;
      notifyListeners();
    }
  }
}
