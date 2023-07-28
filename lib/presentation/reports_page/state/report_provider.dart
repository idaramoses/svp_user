import 'package:flutter/material.dart';
import 'package:svp_admin_pm/models/reports.dart';

import '../../../models/post.dart';

class ReportProvider extends ChangeNotifier {
  List<Reports> _posts;
  List<Attatment> _attatchment;
  List<Activities> _actiities;
  // List<Post> _myPosts;
  // List<Post> _peerPosts;
  // List<Post> _postsByClassmates;
  // String _nextPageUrl;
  // String _myNextPageUrl;
  // String _peerNextPageUrl;

  //get

  List<Reports> get posts => _posts;
  List<Attatment> get attatchment => _attatchment;
  List<Activities> get actiities => _actiities;

  // List<Post> get peerPosts => _peerPosts;
  //
  // List<Post> get myPosts => _myPosts;
  //
  // List<Post> get postsByClassmates => _postsByClassmates;
  //
  //
  // String get nextPageUrl => _nextPageUrl;
  //
  // String get peerNextPageUrl => _peerNextPageUrl;
  //
  // String get myNextPageUrl => _myNextPageUrl;

  //setter
  // set nextPageUrl(String url) {
  //   _nextPageUrl = url;
  //   notifyListeners();
  // }
  //
  // set myNextPageUrl(String url) {
  //   _myNextPageUrl = url;
  //   notifyListeners();
  // }
  //
  // set peerNextPageUrl(String url) {
  //   _peerNextPageUrl = url;
  //   notifyListeners();
  // }
  //

  set posts(List<dynamic> postList) {
    if (postList != null) {
      List<Reports> _postList = [];

      postList.forEach((dynamic data) {
        _postList.add(
          Reports.fromJson(
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
  // set bayBusinesses(List<dynamic> data) {
  //   if (data != null) {
  //     List<Business> _data = [];
  //
  //     data.forEach((element) {
  //       _data.add(
  //         Business.fromJson(
  //           Map<String, dynamic>.from(element),
  //         ),
  //       );
  //     });
  //
  //     _bayBusinesses = _data;
  //     notifyListeners();
  //   }
  // }


  // nullifyMyPosts() {
  //   _myPosts = null;
  //   _myNextPageUrl = null;
  //   notifyListeners();
  // }
  //
  // nullifyPeerPosts() {
  //   _peerPosts = null;
  //   _peerNextPageUrl = null;
  //   notifyListeners();
  // }
  //
  // nullifyClassmatesPosts() {
  //   _postsByClassmates = null;
  //   notifyListeners();
  // }
}
