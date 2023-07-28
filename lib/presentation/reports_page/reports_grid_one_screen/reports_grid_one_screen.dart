
import 'package:animated_horizontal_calendar/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/models/reports.dart';
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
import '../state/report_controller.dart';
import '../state/report_provider.dart';





class ReportGridScreen extends StatefulWidget {
  @override
  _ReportGridScreenState createState() => _ReportGridScreenState();
}

class _ReportGridScreenState extends State<ReportGridScreen> {
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
      await ReportController(context: context).getPosts();
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
        child: Consumer<ReportProvider>(builder: (context, value, child) {
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

  Widget ProjectBody(ReportProvider value) {
    if (value.posts == null) {
      return loader();
    } else if (value.posts.length == 0) {
      emptyPostWidget("No Posts.");
    } else {
      List<Reports> categoryPost = [];
      //List<Post> postsByClassmates = [];

      //get user groups ids

      //get post by category
      value.posts.forEach((element) {
        categoryPost.add(element);
      });

      if (categoryPost.length == 0) {
        emptyPostWidget("No Report.");
      } else
        return listViewBuilder(categoryPost);
    }
    return emptyPostWidget("No Report.");
  }


  Widget listViewBuilder(List<Reports> postList) {
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
              Reports post = postList[index];
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


  Widget postCard(Reports post) {
    String  date = post.date;
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return InkWell(
      onTap: (){
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => TasksDetailsScreen(
        //         id: post.id,
        //         user_status :post.user_status,
        //         name :post.name,
        //         size :post.size,
        //         due :dueoutputDate,
        //         date :outputDate,
        //         star :post.star,
        //         projectName :post.projectName,
        //         projectUserID :post.projectUserID,
        //         projectID :post.projectID,
        //         assignFirstName :post.assignFirstName,
        //         assignLastName :post.assignLastName,
        //         assignID :post.assignID,
        //         assignAvata :post.assignAvata,
        //         attachment: post.attactment,
        //
        //     )
        // )
        // );

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgImage1124x166,
              height: getVerticalSize(
                124,
              ),
              width: getHorizontalSize(
                166,
              ),
              radius: BorderRadius.circular(
                getHorizontalSize(
                  16,
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                top: 8,
              ),
              child: Row(
                children: [
                  CustomImageView(
                    svgPath: ImageConstant.imgBookmark,
                    height: getSize(
                      24,
                    ),
                    width: getSize(
                      24,
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 8,
                      top: 3,
                    ),
                    child: Text(
                      post.projectname,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtSFProTextSemibold16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: getMargin(
                top: 4,
              ),
              decoration: AppDecoration.outlineGray3002,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: getPadding(
                      top: 8,
                    ),
                    child: Text(
                      "Sent by:",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtSFProTextSemibold14,
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 4,
                      top: 7,
                    ),
                    child: Text(
                      post.sent_fromFirstName,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtSFProTextMedium14OrangeA200,
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 22,
                      top: 8,
                    ),
                    child: Text(
                      outputDate,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtSFProTextMedium14Gray500,
                    ),
                  ),
                ],
              ),
            ),
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
