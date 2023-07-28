import 'package:dio/dio.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:provider/provider.dart';

import '../../../utils/services.dart';


class TaskService with Services {
  Future<Map<String, dynamic>> addProject(Map<String, dynamic> credentials, String id) async {
    try {
      final response = await apiPostRequests("user/approvals/$id", credentials);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
  // Future<Map<String, dynamic>> uploadatachment(Map<String, dynamic> credentials, String id, List<PlatformFile> paths,) async {
  //   try {
  //     final response = await apiPatchWithMultiPart("admin/tasks/update/$id",paths,);
  //     return response;
  //   } catch (e) {
  //     print(e);
  //   }
  //   return {};
  // }
  Future<Map<String, dynamic>> getaproval(Map<String, dynamic> credentials) async {
    try {
      final response = await apiGetRequests("users/approvals/${credentials["id"]}");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
  Future<Map<String, dynamic>> getPMTasks() async {
    try {
      final response = await apiGetRequests("user/tasks");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
  Future<Map<String, dynamic>> getAdminTasks() async {

    try {
      final response = await apiGetRequests("user/tasks");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
  Future<Map<String, dynamic>> getspecificPMTasks(String id) async {
    try {
      final response = await apiGetRequests("user/tasks/project/$id");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
  Future<Map<String, dynamic>> getspecificAdminTasks(String id) async {

    try {
      final response = await apiGetRequests("user/tasks/project/$id");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }


}
