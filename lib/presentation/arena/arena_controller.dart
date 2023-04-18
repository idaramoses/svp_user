
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/arena/state/arena_provider.dart';

import '../../utils/app_local_storage.dart';
import '../../utils/flushbar_mixin.dart';
import 'arena_service.dart';

class ArenaController with FlushBarMixin {
  BuildContext context;
  ArenaProvider arenaProvider;
  ArenaService arenaService = ArenaService();
  AppLocalStorage storage = AppLocalStorage();

  ArenaController({
    @required this.context,
  });



  Future getPosts() async {
    try {
      Map<String, dynamic> response = await arenaService.getPosts();
      if (response["status"] == "success") {
        await storage.store("posts", response["body"]);
        context.read<ArenaProvider>().posts =
        response["body"];

      } else {
        context.read<ArenaProvider>().posts = [];
        print("couldn't get post");
      }
    } catch (e) {
      context.read<ArenaProvider>().posts = [];
      print(e);
    }
  }

}
