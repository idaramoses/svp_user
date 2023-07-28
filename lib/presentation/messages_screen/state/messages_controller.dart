
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_service.dart';

import '../../../utils/app_local_storage.dart';
import '../../../utils/flushbar_mixin.dart';
import '../../auth/signin/state/auth_provider.dart';
import 'messages_provider.dart';
import 'messages_service.dart';

class MessagesController with FlushBarMixin {
  BuildContext context;
  MessagesProvider notificationProvider;
  Messageservice notificationService = Messageservice();
  AppLocalStorage storage = AppLocalStorage();

  MessagesController({
    @required this.context,
  });



  Future getPosts() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;
    try {
        Map<String, dynamic> response = await notificationService.getPMnotification();
        if (response["status"] == "success") {
          await storage.store("notifications", response["body"]);
          context.read<MessagesProvider>().posts =
          response["body"];

        } else {
          context.read<MessagesProvider>().posts = [];
          print("couldn't get post");
        }

    } catch (e) {
      context.read<MessagesProvider>().posts = [];
      print(e);
    }
  }
  Future<int> getPostsLength() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;
    var messagelenght;
    try {

        Map<String, dynamic> response = await notificationService.getPMnotification();
        if (response["status"] == "success") {
          List posts = List<Map<String, dynamic>>.from(response["body"]);
          return posts.length;
        } else {
          return 0;
        }


    } catch (e) {
      context.read<MessagesProvider>().posts = [];
      print(e);
    }

  }

}
