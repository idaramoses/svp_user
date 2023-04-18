
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/arena/state/arena_provider.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../models/post.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../utils/app_local_storage.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import 'arena_controller.dart';

class ArenaScreen extends StatefulWidget {
  @override
  _ArenaScreenState createState() => _ArenaScreenState();
}

class _ArenaScreenState extends State<ArenaScreen> {
  AppLocalStorage storage = AppLocalStorage();
  String selectedCategory;
  String reportReason;
  bool isClassmatesSelected = false;
  bool isCategorySelected = false;
  bool isPGroupSelected = false;
  int currentIndex = 0;
  final scrollController = ScrollController();
  int selectedId;
  int reportedPostId;
  int currentPostId = 0;
  List<String> categories = ["All"];

  bool isLoading = false;
  bool loadingMore = false;
  bool isInit = false;
  bool isFollowing = false;
  bool radioValue1 = false;
  bool radioValue2 = false;
  bool isReporting = false;
  bool isFirstTimeClassmatesTapped = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCategory = 'All';
      isCategorySelected = true;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isInit) {
      await ArenaController(context: context).getPosts();

      setState(() {
        isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ArenaProvider>(builder: (context, value, child) {
        if (value.posts == null)
          return loader();
        else {
          return Column(
            children: [
              Expanded(child: arenaBody(value)),
            ],
          );
        }
      }),
    );
  }

  Widget arenaBody(ArenaProvider value) {
    if (value.posts == null) {
      return loader();
    } else if (value.posts.length == 0) {
      emptyPostWidget("No Posts.");
    } else {
      List<Post> categoryPost = [];
      //List<Post> postsByClassmates = [];

      //get user groups ids

      //get post by category
      value.posts.forEach((element) {
        if (selectedCategory == 'All') {
          categoryPost.add(element);
        }

      });

      if (isClassmatesSelected) {

      } else if (isCategorySelected) {
        if (categoryPost.length == 0) {
          emptyPostWidget("No Posts.");
        } else
          return listViewBuilder(categoryPost);
      }
    }
    return emptyPostWidget("No Posts.");
  }

  // Widget arenaBody(ArenaProvider value) {
  //   List<Post> categoryPost = [];
  //   if (value.posts == null) {
  //     return loader();
  //   } else if (value.posts.length == 0) {
  //     emptyPostWidget("Empty Posts.");
  //   } else {
  //     List<Post> categoryPost = [];
  //     List<int> userGroupIds = [];
  //
  //
  //     //get post by category
  //     value.posts.forEach((element) {
  //       categoryPost.add(element);
  //     });
  //
  //     // //get classmates posts
  //     // value.posts.forEach((element) {
  //     //   if (userGroupIds.contains(element.groupId)) {
  //     //     postsByClassmates.add(element);
  //     //   }
  //     // });
  //     if (categoryPost.length == 0) {
  //       emptyPostWidget("No Posts.");
  //     } else
  //       return listViewBuilder(categoryPost);
  //   }
  //   return Text('${value.posts.length}');
  // }

  Widget listViewBuilder(List<Post> postList) {
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
              Post post = postList[index];

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

  Future loadMore() async {
    if (!loadingMore) {
      setState(() {
        loadingMore = true;
      });

      setState(() {
        loadingMore = false;
      });
    }
  }


  Widget postCard(Post post) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              child: Container(
                decoration: AppDecoration.outlineOrangeA2001,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      child: Container(
                        padding: getPadding(
                          left: 16,
                          top: 10,
                          right: 16,
                          bottom: 10,
                        ),
                        decoration: AppDecoration.outlineGray100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: getHorizontalSize(
                                            121,
                                          ),
                                          child: Text(
                                            post.name,
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtSFProTextSemibold16Gray800,
                                          ),
                                        ),
                                        CustomImageView(
                                          svgPath: ImageConstant.imgFolder,
                                          height: getSize(
                                            24,
                                          ),
                                          width: getSize(
                                            24,
                                          ),
                                          margin: getMargin(
                                            left: 8,
                                            top: 1,
                                            bottom: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 8,
                                      ),
                                      child: Text(
                                        "Sujimoto Companies",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtSFProTextMedium14Gray500,
                                      ),
                                    ),
                                  ],
                                ),
                                CustomButton(
                                  height: getVerticalSize(
                                    30,
                                  ),
                                  width: getHorizontalSize(
                                    94,
                                  ),
                                  text: "In Progress",
                                  margin: getMargin(
                                    top: 17,
                                    bottom: 17,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: getMargin(
                                top: 7,
                                bottom: 1,
                              ),
                              decoration: AppDecoration.outlineGray3002,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      top: 7,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Due date:",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtSFProTextSemibold14,
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            top: 8,
                                          ),
                                          child: Row(
                                            children: [
                                              CustomImageView(
                                                svgPath: ImageConstant.imgCalendar,
                                                height: getSize(
                                                  16,
                                                ),
                                                width: getSize(
                                                  16,
                                                ),
                                                margin: getMargin(
                                                  bottom: 1,
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  left: 8,
                                                ),
                                                child: Text(
                                                  "17/01/23",
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtSFProTextMedium14Gray500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: getPadding(
                                      top: 21,
                                      bottom: 11,
                                    ),
                                    child: Text(
                                      "Assigned to:",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextSemibold14,
                                    ),
                                  ),
                                  Container(
                                    width: getSize(
                                      24,
                                    ),
                                    margin: getMargin(
                                      left: 8,
                                      top: 17,
                                      bottom: 9,
                                    ),
                                    padding: getPadding(
                                      all: 4,
                                    ),
                                    decoration:
                                    AppDecoration.txtFillOrangeA200.copyWith(
                                      borderRadius:
                                      BorderRadiusStyle.txtCircleBorder12,
                                    ),
                                    child: Text(
                                      "JA",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextMedium12WhiteA700
                                          .copyWith(
                                        letterSpacing: getHorizontalSize(
                                          0.06,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }


  void openArticle({
    int id,
    String category,
    String title,
    String content,
    int posterId,
    String reposted,
    int repostId,
    String posterName,
    String posterImage,
    String posterPlayerId,
  }) {
    Navigator.of(context).pushNamed("/article_detail", arguments: {
      "id": id,
      "category": category,
      "title": title,
      "content": content,
      "poster_id": posterId,
      "poster_name": posterName,
      "poster_image": posterImage,
      "poster_player_id": posterPlayerId,
      "type": "post",
      "reposted": reposted,
      "repost_id": repostId
    });
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
    return Center(
      child: Text(
        text,
        style:
        TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }


}
