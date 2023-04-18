import 'package:flutter/material.dart';

import '../../../models/post.dart';

class ArenaProvider extends ChangeNotifier {
  List<Post> _posts;
  // List<Post> _myPosts;
  // List<Post> _peerPosts;
  // List<Post> _postsByClassmates;
  // String _nextPageUrl;
  // String _myNextPageUrl;
  // String _peerNextPageUrl;

  //get

  List<Post> get posts => _posts;

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
      List<Post> _postList = [];

      postList.forEach((dynamic data) {
        _postList.add(
          Post.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      });

      _posts = _postList;
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
