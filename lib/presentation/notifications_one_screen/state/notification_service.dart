import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../utils/services.dart';


class NotificationService with Services {
  Future<Map<String, dynamic>> gnotiffication(Map<String, dynamic> credentials) async {
    try {
      final response = await apiGetRequests("${credentials["role"]}/${credentials["type"]}s/${credentials["id"]}");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
  Future<Map<String, dynamic>> getPMnotification() async {

    try {
      final response = await apiGetRequests("user/notifications");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
  Future<Map<String, dynamic>> getAdminnotification() async {

    try {
      final response = await apiGetRequests("user/notifications");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

}
