import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/tasks_list_tab_container_page/state/task_provider.dart';
import 'package:svp_admin_pm/presentation/tasks_list_tab_container_page/task_service.dart';

import '../../utils/app_local_storage.dart';
import '../../utils/flushbar_mixin.dart';

class TasksController with FlushBarMixin {
  BuildContext context;
  TasksService _tasksService = TasksService();
  AppLocalStorage storage = AppLocalStorage();

  TasksController({
    @required this.context,
  });
  // Future getPosts() async {
  //   try {
  //     Map<String, dynamic> response = await _tasksService.getPosts();
  //     if (response["status"] == "success") {
  //       await storage.store("posts", response["body"]["data"]["data"]);
  //       await storage.store(
  //           "next_page_url", response["body"]["data"]["next_page_url"]);
  //       context.read<TasksProvider>().Taskss = response["body"]["data"]["data"];
  //     } else {
  //       context.read<TasksProvider>().Taskss = [];
  //       print("couldn't get post");
  //     }
  //   } catch (e) {
  //     context.read<TasksProvider>().Taskss = [];
  //     print(e);
  //   }
  // }
}
