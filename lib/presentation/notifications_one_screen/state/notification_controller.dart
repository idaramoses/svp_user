
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_service.dart';

import '../../../models/post.dart';
import '../../../models/tasks.dart';
import '../../../utils/app_local_storage.dart';
import '../../../utils/flushbar_mixin.dart';
import '../../auth/signin/state/auth_provider.dart';
import '../../projects_main/projects_details_screen/projects_details_screen.dart';
import '../../tasks_page_main/task_details_screen/task_details_screen.dart';
import 'notification_provider.dart';
import 'notification_service.dart';

class NotificationController with FlushBarMixin {
  BuildContext context;
  NotificationProvider notificationProvider;
  NotificationService notificationService = NotificationService();
  AppLocalStorage storage = AppLocalStorage();

  NotificationController({
    @required this.context,
  });



  Future getPosts() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;
    try {
      if (role == 'Admin'){
        Map<String, dynamic> response = await notificationService.getAdminnotification();
        if (response["status"] == "success") {
          await storage.store("notifications", response["body"]);
          context.read<NotificationProvider>().posts =
          response["body"];

        } else {
          context.read<NotificationProvider>().posts = [];
          print("couldn't get post");
        }
      }else{
        Map<String, dynamic> response = await notificationService.getPMnotification();
        if (response["status"] == "success") {
          await storage.store("notifications", response["body"]);
          context.read<NotificationProvider>().posts =
          response["body"];

        } else {
          context.read<NotificationProvider>().posts = [];
          print("couldn't get post");
        }
      }

    } catch (e) {
      context.read<NotificationProvider>().posts = [];
      print(e);
    }
  }

  Future<void> getnotiffication(Map<String, dynamic> credentials) async {

    try {
      Map<String, dynamic> response =
      await notificationService.gnotiffication({...credentials});

      if (response["status"] == "success") {


        if (credentials["type"] == 'project') {
          String  date =  response["body"]['date'];
          DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('MM/dd/yyyy');
          var outputDate = outputFormat.format(inputDate);
          String  duedate = response["body"]['due'];
          DateTime dueparseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(duedate);
          var dueinputDate = DateTime.parse(dueparseDate.toString());
          var dueoutputFormat = DateFormat('MM/dd/yyyy');
          var dueoutputDate = dueoutputFormat.format(dueinputDate);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProjectsDetailsScreen(
                id: response["body"]["id"],
                name: response["body"]["name"],
                user_status : response["body"]['user_status'],
                admin_Status: response["body"]["admin_Status"],
                priority: response["body"]['priority'],
                size: response["body"]['size'],
                due: outputDate,
                budget: response["body"]['budget'],
                details: response["body"]['details'],
                building_type: response["body"]['building_type'],
                facilities: response["body"]["facilities"],
                date: dueoutputDate,
                requstFirstName: response["body"]['requested_by']['firstname'],
                requstLastName: response["body"]['requested_by']['lastname'],
                requstID: response["body"]['requested_by']['id'],
                assignFirstName: response["body"]['assigned_to']['firstname'],
                assignLastName: response["body"]['assigned_to']['lastname'],
                assignID: response["body"]['assigned_to']['id'],
                assignAvata: response["body"]['assigned_to']['avatar'],
                star: response["body"]["star"],
                design: response["body"]['design'],
                site_condition: response["body"]['site_condition'],
                activites : List.from(response["body"]['activities']).map((e) => Activities.fromJson(e)).toList(),
                attachment : List.from(response["body"]['attachments']).map((e) => Attatment.fromJson(e)).toList(),
              )));
              return;
              }
        if (credentials["type"] == 'task') {
          String  date =  response["body"]['date'];
          DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('MM/dd/yyyy');
          var outputDate = outputFormat.format(inputDate);
          String  duedate = response["body"]['due'];
          DateTime dueparseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(duedate);
          var dueinputDate = DateTime.parse(dueparseDate.toString());
          var dueoutputFormat = DateFormat('MM/dd/yyyy');
          var dueoutputDate = dueoutputFormat.format(dueinputDate);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => TasksDetailsScreen(
                id: response["body"]["_id"],
                name: response["body"]["name"],
                user_status : response["body"]['status'],
                size: response["body"]['size'],
                due: dueoutputDate,
                date: outputDate,
                assignFirstName: response["body"]['assigned_to']['firstname'],
                assignLastName: response["body"]['assigned_to']['lastname'],
                assignID: response["body"]['assigned_to']['id'],
                assignAvata: response["body"]['assigned_to']['avatar'],
                star: response["body"]["star"],
                projectName: response["body"]['name'],
                projectUserID: response["body"]['user_id'],
                projectID: response["body"]['id'],
                approvalId: response["body"]['approval_id'],
                attachment : List.from(response["body"]['attachments']).map((e) => TasksAttatment.fromJson(e)).toList(),
              )));
          return;
        }
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
