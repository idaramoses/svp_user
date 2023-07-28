import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../utils/services.dart';


class ProjectService with Services {
  Future<Map<String, dynamic>> addProject(Map<String, dynamic> credentials) async {
    try {
      final response = await apiPostRequests("users/projects/new", credentials);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
  Future<Map<String, dynamic>> getPMProject() async {

    try {
      final response = await apiGetRequests("user/projects");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map<String, dynamic>> getAdminProject() async {

    try {
      final response = await apiGetRequests("user/projects");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

}
