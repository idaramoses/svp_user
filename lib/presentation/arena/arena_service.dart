import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../utils/services.dart';

class ArenaService with Services {

  Future<Map<String, dynamic>> getPosts() async {
    try {
      final response = await apiGetRequests("user/projects");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }


}
