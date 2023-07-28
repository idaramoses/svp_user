
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

import '../../../../core/utils/color_constant.dart';
import '../../../../core/utils/image_constant.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../models/tasks.dart';
import '../../../../theme/app_decoration.dart';
import '../../../../theme/app_style.dart';
import '../../../../utils/app_local_storage.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../tasks_page_main/state/task_controller.dart';
import '../../tasks_page_main/state/task_provider.dart';
import '../../tasks_page_main/task_details_screen/task_details_screen.dart';





class TaskWidget extends StatefulWidget {
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
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
      body: Consumer<TaskProvider>(builder: (context, value, child) {
        if (value.posts == null)
          return loader();
        else {
          return Column(
            children: [
              Padding(
                padding: getPadding(
                  top: 24,
                  bottom: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 3,
                      ),
                      child: Text(
                        "Tasks In Progress",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextBold16,
                      ),
                    ),
                    CustomDropDown(
                      width: getHorizontalSize(
                        80,
                      ),
                      focusNode: FocusNode(),
                      icon: Container(
                        margin: getMargin(
                          left: 5,
                        ),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgArrowdownOrangeA200,
                        ),
                      ),
                      hintText: "View all",
                      variant: DropDownVariant.None,
                      padding: DropDownPadding.PaddingT2,
                      fontStyle:
                      DropDownFontStyle.SFProTextSemibold14OrangeA200,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              Expanded(child: ProjectBody(value)),
            ],
          );
        }
      }),
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
        emptyPostWidget("No Project.");
      } else
        return listViewBuilder(categoryPost);
    }
    return emptyPostWidget("No Project.");
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
                                        post.projectName,
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
                                  variant: post.user_status == 'Approved'? ButtonVariant.Success:post.user_status == 'Declied'? ButtonVariant.Error:ButtonVariant.FillGray500,
                                  text: post.user_status,
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
                                                  dueoutputDate,
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
                                      "Assigned to: ",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextSemibold14,
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
