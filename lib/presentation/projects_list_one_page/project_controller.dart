
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/projects_list_one_page/project_provider.dart';
import 'package:svp_admin_pm/presentation/projects_list_one_page/project_service.dart';

import '../../models/project.dart';
import '../../utils/flushbar_mixin.dart';

class ProjectController with FlushBarMixin {
  BuildContext context;
  ProjectService eventService = ProjectService();
  ProjectProvider eventProvider;

  ProjectController({@required this.context});
  Future getuserprofile() async {

    try {
      Map<String, dynamic> response = await eventService.userproject();
      // var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      // var response = await http.get(url);
      // final response = await apiGetRequests("user/projects");
      if (response["status"] == "success") {
        try {
          // var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
          // var response = await http.get(url);
          // List<ProjectModel> _model = ProjectModelFromJson(response["body"]);
          // return _model;
        } catch (e) {
          // log(e.toString());
        }
      } else {
        // alumniProvider.totalreferals = 0;
      }
    } catch (e) {
      print(e);
    }
  }
}
