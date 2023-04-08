import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/models/tasks.dart';
import 'package:svp_admin_pm/presentation/tasks_list_tab_container_page/tasks_controller.dart';

import '../../utils/flushbar_mixin.dart';
import '../auth/signin/state/auth_provider.dart';
import '../tasks_list_page/widgets/tasks_list_item_widget.dart';
import '../tasks_list_tab_container_page/state/task_provider.dart';

// ignore_for_file: must_be_immutable
class TasksListPage extends StatefulWidget {
  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> with FlushBarMixin {
  bool isInit = false;
  bool loadingMore = false;
  final scrollController = ScrollController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isInit) {
      await TasksController(context: context).getPosts();
      setState(() {
        isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 26,
                      ),
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: getVerticalSize(
                              16,
                            ),
                          );
                        },
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return TasksListItemWidget();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget arenaBody(TasksProvider value) {
    List<Tasks> categoryPost = [];

    if (value.posts == null) {
      return loader();
    } else if (value.posts.length == 0) {
      emptyPostWidget("No Posts.");
    } else {
      return listViewBuilder(categoryPost);
    }
    return emptyPostWidget("No Posts.");
  }

  Widget postCard(Tasks post) {
    var date = DateTime.parse(post.createdAt);
    var time = DateFormat("MMM d, h:m a").format(date.add(Duration(hours: 1)));
    int userId = Provider.of<AuthProvider>(context, listen: false).userInfo.id;
    return InkWell(
      // onTap: () => post.isPromoted == "true"
      //     ? () {}
      //     : openArticle(
      //     id: post.id,
      //     category: post.categoryName,
      //     title: post.title,
      //     content: post.content,
      //     posterId: post.userId,
      //     posterName: post.userName,
      //     posterImage: post.userPhoto,
      //     posterPlayerId: post.userPlayerId,
      //     reposted: post.reposted == "true" ? "true" : "false",
      //     repostId: post.repostId == null ? 0 : int.parse(post.repostId)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                post.isPromoted,
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listViewBuilder(List<Tasks> postList) {
    return NotificationListener(
      onNotification: (ScrollEndNotification notification) {
        if (notification is ScrollEndNotification &&
            scrollController.position.extentAfter == 0) {
          print('end');
          loadMore();
        }
        return false;
      },
      child: ListView(
        controller: scrollController,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Tasks post = postList[index];

              return postCard(post);
            },
            itemCount: postList.length,
          ),
          loadingMore
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget loader() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return PKCardSkeleton();
      },
    );
  }

  Widget emptyPostWidget(String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
              color: ColorConstant.orangeA200, fontWeight: FontWeight.bold),
        ),
        // FlatButton(
        //   onPressed: () async {
        //     await ArenaController(context: context).getPosts();
        //     await ArenaController(context: context).getCategories();
        //   },
        //   child: Text("Refresh"),
        // )
      ],
    );
  }

  Future loadMore() async {
    if (!loadingMore) {
      setState(() {
        loadingMore = true;
      });

      // await ArenaController(context: context).getMorePosts();
      setState(() {
        loadingMore = false;
      });
    }
  }
}
