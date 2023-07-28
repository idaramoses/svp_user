
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_service.dart';
import 'package:svp_admin_pm/presentation/reports_page/state/report_provider.dart';
import 'package:svp_admin_pm/presentation/reports_page/state/report_service.dart';

import '../../../utils/app_local_storage.dart';
import '../../../utils/flushbar_mixin.dart';
import '../../auth/signin/state/auth_provider.dart';

class ReportController with FlushBarMixin {
  BuildContext context;
  ReportProvider projectProvider;
  ReportService projectService = ReportService();
  AppLocalStorage storage = AppLocalStorage();

  ReportController({
    @required this.context,
  });



  Future getPosts() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;
    try {

        Map<String, dynamic> response = await projectService.getPMProject();
        if (response["status"] == "success") {
          await storage.store("reports", response["body"]);
          context.read<ReportProvider>().posts =
          response["body"];

        } else {
          context.read<ReportProvider>().posts = [];
          print("couldn't get post");

      }

    } catch (e) {
      context.read<ReportProvider>().posts = [];
      print(e);
    }
  }

}
