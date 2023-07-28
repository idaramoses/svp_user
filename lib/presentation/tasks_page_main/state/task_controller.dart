
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/src/asset.dart';

import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_service.dart';
import 'package:svp_admin_pm/presentation/tasks_page_main/state/task_provider.dart';
import 'package:svp_admin_pm/presentation/tasks_page_main/state/task_service.dart';
import 'package:svp_admin_pm/presentation/tasks_page_main/task_approval.dart';

import '../../../utils/app_local_storage.dart';
import '../../../utils/flushbar_mixin.dart';
import '../../auth/signin/state/auth_provider.dart';

class TaskController with FlushBarMixin {
  BuildContext context;
  String id,status;
  TaskProvider projectProvider;
  TaskService projectService = TaskService();
  AppLocalStorage storage = AppLocalStorage();

  TaskController({
    @required this.context,  @required this.id,  @required this.status,
  });


  Future addPost(Map<String, dynamic> credentials) async {
    try {
      Map<String, dynamic> response = await  projectService.addProject(
        credentials,
        id
      );
      if (response["status"] == "success") {
        showSuccessNotification(
            context, "Approval Request $status");
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

  // Future uploadatachment(Map<String, dynamic> credentials, List<PlatformFile> paths,  ) async {
  //   try {
  //     Map<String, dynamic> response = await  projectService.uploadatachment(
  //       credentials,id,paths
  //     );
  //     if (response["status"] == "success") {
  //       showSuccessNotification(
  //           context, "Attachment Added");
  //     } else {
  //       if (response["error"]["message"] != null) {
  //         Fluttertoast.showToast(msg: 'failed');
  //       } else {
  //         Fluttertoast.showToast(msg: 'failed');
  //       }
  //     }
  //   } catch (error) {
  //     print(error);
  //     Fluttertoast.showToast(msg: 'failed');
  //   }
  // }
  Future getPosts() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;
    try {
      if (role == 'Admin'){
        Map<String, dynamic> response = await projectService.getAdminTasks();
        if (response["status"] == "success") {
          await storage.store("tasks", response["body"]);
          context.read<TaskProvider>().posts =
          response["body"];

        } else {
          context.read<TaskProvider>().posts = [];
          print("couldn't get post");
        }
      }else{
        Map<String, dynamic> response = await projectService.getPMTasks();
        if (response["status"] == "success") {
          await storage.store("tasks", response["body"]);
          context.read<TaskProvider>().posts =
          response["body"];

        } else {
          context.read<TaskProvider>().posts = [];
          print("couldn't get post");
        }
      }

    } catch (e) {
      context.read<TaskProvider>().posts = [];
      print(e);
    }
  }
  Future getspecialPosts(String id) async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;
    try {
      if (role == 'Admin'){
        Map<String, dynamic> response = await projectService.getspecificAdminTasks(id);
        if (response["status"] == "success") {
          context.read<TaskProvider>().posts =
          response["body"];

        } else {
          context.read<TaskProvider>().posts = [];
          print("couldn't get post");
        }
      }else{
        Map<String, dynamic> response = await projectService.getspecificPMTasks(id);
        if (response["status"] == "success") {
          context.read<TaskProvider>().posts =
          response["body"];

        } else {
          context.read<TaskProvider>().posts = [];
          print("couldn't get post");
        }
      }

    } catch (e) {
      context.read<TaskProvider>().posts = [];
      print(e);
    }
  }
  Future<void> getapproval(Map<String, dynamic> credentials) async {

    try {
      Map<String, dynamic> response =
      await projectService.getaproval({...credentials});

      if (response["status"] == "success") {


          String  date =  response["body"]['start'];
          DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('MM/dd/yyyy');
          var outputDate = outputFormat.format(inputDate);
          String  requestdate =  response["body"]['requested_on'];
          DateTime requestparseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(requestdate);
          var requestinputDate = DateTime.parse(parseDate.toString());
          var requestoutputFormat = DateFormat('MM/dd/yyyy');
          var requestoutputDate = requestoutputFormat.format(requestinputDate);
          String  duedate = response["body"]['due'];
          DateTime dueparseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(duedate);
          var dueinputDate = DateTime.parse(dueparseDate.toString());
          var dueoutputFormat = DateFormat('MM/dd/yyyy');
          var dueoutputDate = dueoutputFormat.format(dueinputDate);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => TaskAprovalScreen(
                id: response["body"]["_id"],
                comments: response["body"]["comments"],
                user_status : response["body"]['status'],
                request_on: requestoutputDate,
                due: dueoutputDate,
                date: outputDate,
                requestFirstName: response["body"]['requested_by']['firstname'],
                requestLastName: response["body"]['requested_by']['lastname'],
                requestID: response["body"]['requested_by']['id'],
                projectName: response["body"]['project']['name'],
                projectID: response["body"]['project']['id'],
                taskName: response["body"]['task']['name'],
                taskID: response["body"]['task']['id'],
                // attachment : List.from(response["body"]['attachments']).map((e) => TasksAttatment.fromJson(e)).toList(),
              )));
          return;

      } else if (response["status"] == "error" &&
          response["message"] == "Invalid Credentials.") {
        showErrorNotification(
            context, "Network Error, Check your internet connection.!");
      } else if (response["error"]["message"] ==
          "Your credentials does not match our record.") {
        showErrorNotification(
            context, "Network Error, Check your internet connection.!");
      } else {
        showErrorNotification(
            context, "Network Error, Check your internet connection.!");
      }
    } catch (error) {
      print(error);
      showErrorNotification(
          context, "Network Error, Check your internet connection.!");
    }
  }
}
