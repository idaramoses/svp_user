
import 'dart:convert';
import 'dart:developer';

import '../../models/new_users.dart';
import '../../models/project.dart';
import '../../utils/app_local_storage.dart';
import '../../utils/services.dart';
import '../tasks_list_tab_container_page/task_service.dart';
import 'package:http/http.dart' as http;



class ProjectService with Services {

  // Future<List<ProjectModel>> getUsers() async {
  //
  //   try {
  //     // var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
  //     // var response = await http.get(url);
  //     final response = await apiGetRequests("user/projects");
  //     if (response.statusCode == 200) {
  //       List<ProjectModel> _model = ProjectModelFromJson(response.body);
  //       return _model;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<Map<String, dynamic>> userproject() async {
    try {
      final response = await apiGetRequests("users");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }


}
