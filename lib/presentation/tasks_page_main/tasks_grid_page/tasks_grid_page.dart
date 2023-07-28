
import 'package:animated_horizontal_calendar/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/projects_main/projects_details_screen/projects_details_screen.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_controller.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_provider.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../../core/utils/size_utils.dart';
import '../../../models/tasks.dart';
import '../../../theme/app_decoration.dart';
import '../../../theme/app_style.dart';
import '../../../utils/app_local_storage.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../state/task_controller.dart';
import '../state/task_provider.dart';
import '../task_details_screen/task_details_screen.dart';




class TaskGridScreen extends StatefulWidget {
  @override
  _TaskGridScreenState createState() => _TaskGridScreenState();
}

class _TaskGridScreenState extends State<TaskGridScreen> {
  AppLocalStorage storage = AppLocalStorage();
  String selectedCategory;
  String reportReason;
  bool isClassmatesSelected = false;
  bool isCategorySelected = false;
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
      await TaskController(context: context).getPosts();
      setState(() {
        isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray200,
      body: Padding(
        padding: getPadding(
          left: 16,
          right: 16,
          top: 25,
        ),
        child: Consumer<TaskProvider>(builder: (context, value, child) {
          if (value.posts == null)
            return loader();
          else {
            return Column(
              children: [
                Expanded(child: ProjectBody(value)),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget ProjectBody(TaskProvider value) {
    if (value.posts == null) {
      return loader();
    } else if (value.posts.length == 0) {
      emptyPostWidget("No Posts.");
    } else {
      List<Tasks> categoryPost = [];
      //List<Post> postsByClassmates = [];

      //get user groups ids

      //get post by category
      value.posts.forEach((element) {
        categoryPost.add(element);
      });

      if (categoryPost.length == 0) {
        emptyPostWidget("No Tasks.");
      } else
        return listViewBuilder(categoryPost);
    }
    return emptyPostWidget("No Tasks.");
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
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: getVerticalSize(
                230,
              ),
              crossAxisCount: 2,
              mainAxisSpacing: getHorizontalSize(
                5,
              ),
              crossAxisSpacing: getHorizontalSize(
                10,
              ),
            ),
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


  Widget postCard(Tasks post) {
    String  date = post.date;
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    String  duedate = post.due;
    DateTime dueparseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(duedate);
    var dueinputDate = DateTime.parse(dueparseDate.toString());
    var dueoutputFormat = DateFormat('MM/dd/yyyy');
    var dueoutputDate = dueoutputFormat.format(dueinputDate);
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TasksDetailsScreen(
              id: post.id,
              user_status :post.user_status,
              name :post.name,
              size :post.size,
              due :dueoutputDate,
              date :outputDate,
              star :post.star,
              projectName :post.projectName,
              projectUserID :post.projectUserID,
              projectID :post.projectID,
              assignFirstName :post.assignFirstName,
              assignLastName :post.assignLastName,
              assignID :post.assignID,
              assignAvata :post.assignAvata,
              attachment: post.attactment,

            )
        )
        );

      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: getPadding(
            all: 10,
          ),
          decoration: AppDecoration.outlineOrangeA2003.copyWith(
            borderRadius: BorderRadiusStyle.circleBorder16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: getHorizontalSize(
                  120,
                ),
                child: Text(
                  post.name,
                  maxLines: null,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextSemibold16Gray800,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 5,
                ),
                child: Text(
                  "Site clearing for 6-Bedroom building for Skyline Building construc...",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextMedium14Gray500,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 5,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 5,
                        bottom: 3,
                      ),
                      child: Text(
                        "Assigned to:",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextBold12Gray500.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.06,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width:  getHorizontalSize(20),
                      height: getHorizontalSize(20),
                      decoration:
                      AppDecoration.txtFillOrangeA200.copyWith(
                        borderRadius:
                        BorderRadiusStyle.txtCircleBorder12,
                      ),
                      child: Center(
                        child: Text(
                          '${post.assignFirstName.substring(0, 1)}''${post.assignLastName.substring(0, 1)}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextMedium12WhiteA700
                              .copyWith(
                            color: white,
                            letterSpacing: getHorizontalSize(
                              0.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 5,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 7,
                        bottom: 7,
                      ),
                      child: Text(
                        "Status:",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextBold12Gray500.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.06,
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      height: getVerticalSize(
                        30,
                      ),
                      width: getHorizontalSize(
                        94,
                      ),
                      variant: post.user_status == 'Approved'? ButtonVariant.Success:post.user_status == 'Declied'? ButtonVariant.Error:ButtonVariant.FillGray500,
                      text:post.user_status,
                      margin: getMargin(
                        left: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 11,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: getPadding(
                        bottom: 1,
                      ),
                      child: Text(
                        "Due:",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextBold12Gray500.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.06,
                          ),
                        ),
                      ),
                    ),
                    CustomImageView(
                      svgPath: ImageConstant.imgCalendar,
                      height: getSize(
                        16,
                      ),
                      width: getSize(
                        16,
                      ),
                      margin: getMargin(
                        left: 11,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 8,
                        top: 1,
                      ),
                      child: Text(
                        outputDate,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextMedium12Gray500.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.06,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 12,
                  bottom: 1,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 5,
                        bottom: 3,
                      ),
                      child: Text(
                        "Priority:",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextBold12Gray500.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.06,
                          ),
                        ),
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
                        left: 10,
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
