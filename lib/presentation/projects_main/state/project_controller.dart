
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_service.dart';

import '../../../utils/app_local_storage.dart';
import '../../../utils/flushbar_mixin.dart';
import '../../auth/signin/state/auth_provider.dart';

class ProjectController with FlushBarMixin {
  BuildContext context;
  ProjectProvider projectProvider;
  ProjectService projectService = ProjectService();
  AppLocalStorage storage = AppLocalStorage();

  ProjectController({
    @required this.context,
  });


  Future addPost(Map<String, dynamic> credentials) async {
    try {
      Map<String, dynamic> response = await  projectService.addProject(
        credentials,
      );
      if (response["status"] == "success") {
        showSuccessNotification(
            context, "Project Added");
      } else {
        if (response["error"]["message"] != null) {
          Fluttertoast.showToast(msg: 'failed');
        } else {
          Fluttertoast.showToast(msg: 'failed');
        }
      }
    } catch (error) {
      print(error);
      Fluttertoast.showToast(msg: 'failed');
    }
  }

  Future getPosts() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;
    try {
      if (role == 'Admin'){
        Map<String, dynamic> response = await projectService.getAdminProject();
        if (response["status"] == "success") {
          await storage.store("projects", response["body"]);
          context.read<ProjectProvider>().posts =
          response["body"];

        } else {
          context.read<ProjectProvider>().posts = [];
          print("couldn't get post");
        }
      }else{
        Map<String, dynamic> response = await projectService.getPMProject();
        if (response["status"] == "success") {
          await storage.store("projects", response["body"]);
          context.read<ProjectProvider>().posts =
          response["body"];

        } else {
          context.read<ProjectProvider>().posts = [];
          print("couldn't get post");
        }
      }

    } catch (e) {
      context.read<ProjectProvider>().posts = [];
      print(e);
    }
  }

}
