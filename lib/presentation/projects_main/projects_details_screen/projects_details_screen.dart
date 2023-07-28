import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/projects_main/projects_details_screen/widgets/projects_widget.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_checkbox.dart';
import 'package:svp_admin_pm/widgets/custom_drop_down.dart';

import '../../../models/post.dart';
import '../../../models/tasks.dart';
import '../../main_dashboard/user_dashboard.dart';
import '../../tasks_page_main/state/task_controller.dart';
import '../../tasks_page_main/state/task_provider.dart';
import '../state/project_provider.dart';

class ProjectsDetailsScreen extends StatefulWidget {
  String id;
  String user_status;
  String admin_Status;
  String priority;
  String name;
  String size;
  String due;
  String budget;
  String building_type;
  bool design;
  String site_condition;
  String facilities;
  bool star;
  String date;
  String details;
  String requstFirstName;
  String requstLastName;
  String requstID;
  String assignFirstName;
  String assignLastName;
  String assignID;
  String assignAvata;
  List<Attatment> attachment = [];
  List<Activities> activites = [];
  ProjectsDetailsScreen(
      {Key key,
        this.id,
        this.user_status,
        this.admin_Status,
        this.priority,
        this.name,
        this.size,
        this.due,
        this.budget,
        this.details,
        this.building_type,
        this.facilities,
        this.site_condition,
        this.date,
        this.design,
        this.star,
        this.requstFirstName,
        this.requstLastName,
        this.requstID,
        this.assignFirstName,
        this.assignLastName,
        this.assignID,
        this.assignAvata,
        this.attachment,
        this.activites})
      : super(key: key);

  @override
  State<ProjectsDetailsScreen> createState() => _ProjectsDetailsScreenState();
}

class _ProjectsDetailsScreenState extends State<ProjectsDetailsScreen> {
  int currentIndex = 0;

  bool checkbox = false;
  bool isallatachment = false;
  bool isInit = false;
  bool isloadcomplete = false;
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isInit) {
      await TaskController(context: context).getspecialPosts(widget.id);
      setState(() {
        isInit = true;
      });
    }
  }
  Future<bool> _willPopCallback() async {
    // exit(0);
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>MainDashboardScreen(id: 1)));
    // return true; // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, valuee, child) {
      if (valuee.posts == null)
        return loader();
      else {
        return WillPopScope(
          onWillPop: _willPopCallback,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: ColorConstant.gray200,
              body: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: getVerticalSize(
                                70,
                              ),
                              width: double.maxFinite,
                              child: Container(
                                width: double.maxFinite,
                                padding: getPadding(
                                  all: 16,
                                ),
                                decoration: AppDecoration.outlineGray300,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: getMargin(
                                              top: 10,
                                            ),
                                            child: Icon(
                                              Icons.arrow_back,
                                              color: ColorConstant.orangeA200,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        CustomImageView(
                                          svgPath: ImageConstant.imgOverflowmenu,
                                          height: getSize(
                                            24,
                                          ),
                                          width: getSize(
                                            24,
                                          ),
                                          margin: getMargin(
                                            top: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: getPadding(
                                  left: 16,
                                  top: 23,
                                  right: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: getHorizontalSize(
                                        136,
                                      ),
                                      child: Text(
                                        widget.name,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtSFProTextSemibold18,
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
                                        bottom: 18,
                                      ),
                                    ),
                                    Spacer(),
                                    CustomButton(
                                      height: getVerticalSize(
                                        30,
                                      ),
                                      width: getHorizontalSize(
                                        94,
                                      ),
                                      text: widget.admin_Status,
                                      margin: getMargin(
                                        top: 6,
                                        bottom: 6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: getHorizontalSize(
                                273,
                              ),
                              margin: getMargin(
                                left: 16,
                                top: 14,
                                right: 85,
                              ),
                              child: Text(
                                widget.details,
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextRegular16Gray800,
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 16,
                                top: 20,
                                right: 35,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      top: 1,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Project created:",
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
                                                  widget.date,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtSFProTextSemibold14Gray800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
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
                                          top: 9,
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
                                                widget.due,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtSFProTextSemibold14Gray800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            widget.assignFirstName == null?  Padding(
                              padding: getPadding(
                                left: 16,
                                top: 15,
                              ),
                              child: Text(
                                "UnAssigned",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextSemibold14,
                              ),
                            ): Padding(
                              padding: getPadding(
                                left: 16,
                                top: 15,
                              ),
                              child: Text(
                                "Assigned to:",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextSemibold14,
                              ),
                            ),
                            widget.assignFirstName == null?  Container(
                              margin: getMargin(
                                left: 16,
                                top: 7,
                              ),
                              decoration: AppDecoration.fillGray200.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder16,
                              ),
                            ): Container(
                              margin: getMargin(
                                left: 16,
                                top: 7,
                              ),
                              decoration: AppDecoration.fillGray200.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder16,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomImageView(
                                    url: widget.assignAvata,
                                    height: getSize(
                                      32,
                                    ),
                                    width: getSize(
                                      32,
                                    ),
                                    radius: BorderRadius.circular(
                                      getHorizontalSize(
                                        16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      left: 8,
                                      top: 6,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      widget.assignFirstName +
                                          ' ' +
                                          widget.assignLastName,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style:
                                      AppStyle.txtSFProTextSemibold14OrangeA200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 16,
                                top: 23,
                              ),
                              child: Text(
                                "Tasks:",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextSemibold16,
                              ),
                            ),
                            ActivitytBody(valuee),



                            Padding(
                              padding: getPadding(
                                left: 16,
                                top: 23,
                              ),
                              child: Text(
                                "Attachments:",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextSemibold16,
                              ),
                            ),
                            Container(
                              margin: getMargin(
                                top: 48,
                              ),
                              child: ProjectBody(),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
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
  Widget ProjectBody() {
    if (widget.attachment == null) {
      return Center(child: emptyPostWidget("No Attachment."));
    } else if (widget.attachment.length == 0) {
      Center(child: emptyPostWidget("No Attachment."));
    } else {
      //List<Post> postsByClassmates = [];
      List<Attatment> categoryPost = [];
      //get user groups ids
      //get post by category
      categoryPost.forEach((element) {
        widget.attachment.add(element);
      });

      if (widget.attachment.length == 0) {
        Center(child: emptyPostWidget("No Attachment."));
      } else
        return listViewBuilder(widget.attachment);
    }
    return  Center(child: emptyPostWidget("No Attachment."));
  }

  Widget listViewBuilder(List<Attatment> attatchmentList) {
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Column(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Attatment attachment = attatchmentList[index];
              return postCard(attachment);
            },
            itemCount: isallatachment? attatchmentList.length:attatchmentList.length < 6?attatchmentList.length: 6,
          ),
          attatchmentList.length > 6 &&   isallatachment == false ?  CustomButton(
            onTap: (){
              setState(() {
                isallatachment = true;
              });
            },
            height: getVerticalSize(
              34,
            ),
            width: getHorizontalSize(
              161,
            ),
            text: "See all Attachments",
            margin: getMargin(
              top: 24,
            ),
            variant: ButtonVariant.OutlineOrangeA200,
            fontStyle: ButtonFontStyle.SFProTextBold12,
            alignment: Alignment.center,
          ):Container(),
        ],
      ),
    );
  }

  Widget postCard(Attatment post) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: getHorizontalSize(
            156,
          ),
          margin: getMargin(
            left: 12,
          ),
          padding: getPadding(
            left: 8,
            top: 3,
            right: 8,
            bottom: 3,
          ),
          decoration: AppDecoration.outlineGray3001.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: ListTile(
            leading:  CustomImageView(
              svgPath: ImageConstant.imgBookmark,
              height: getSize(
                24,
              ),
              width: getSize(
                24,
              ),
              margin: getMargin(
                top: 5,
                bottom: 5,
              ),
            ),title:
          Text(
            post.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextMedium14,
          ), subtitle: Text(
            '${post.size}',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextRegular12,
          ),)
        ),
      ),
    );
  }

  Widget ActivitytBody(TaskProvider valuee) {
    if (valuee.posts == null) {
      return Center(child: emptyPostWidget("No Task."));
    } else if (valuee.posts.length == 0) {
      Center(child: emptyPostWidget("No Task."));
    } else {
      //List<Post> postsByClassmates = [];
      List<Tasks> categoryPost = [];
      //get user groups ids
      //get post by category
      categoryPost.forEach((element) {
        valuee.posts.add(element);
      });

      if (valuee.posts.length == 0) {
        Center(child: emptyPostWidget("No Task."));
      } else
        return  isloadcomplete? ActivitylistViewBuilder(valuee.posts):TweenAnimationBuilder<Duration>(
            duration: Duration(seconds: 2),
            tween: Tween(begin: Duration(seconds: 2), end: Duration.zero),
            onEnd: () {
              setState(() {
                isloadcomplete = true;
              });
            },
            builder: (BuildContext context, Duration value, Widget child) {
              return  PKCardSkeleton();
            });
    }
    return Center(child: emptyPostWidget("No Task."));
  }

  Widget ActivitylistViewBuilder(List<Tasks> attatchmentList) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: getMargin(
                left: 16,
                top: 15,
                right: 16,
              ),
              padding: getPadding(
                all: 16,
              ),
              decoration: AppDecoration.outlineGray3001.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgMenu,
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
                          top: 1,
                          bottom: 2,
                        ),
                        child: Text(
                          "All Tasks",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextSemibold16,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 184,
                          top: 4,
                          bottom: 4,
                        ),
                        child: attatchmentList.length > 5? Text(
                          "5/${attatchmentList.length}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style:
                          AppStyle.txtSFProTextBold12.copyWith(
                            letterSpacing: getHorizontalSize(
                              0.06,
                            ),
                          ),
                        ):Text(
                          "${attatchmentList.length}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style:
                          AppStyle.txtSFProTextBold12.copyWith(
                            letterSpacing: getHorizontalSize(
                              0.06,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: getPadding(
                      top: 8,
                    ),
                    child:attatchmentList.length > 5? Container(
                      height: getVerticalSize(
                        8,
                      ),
                      width: getHorizontalSize(
                        311,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.gray300,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            4,
                          ),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            4,
                          ),
                        ),
                        child: LinearProgressIndicator(
                          value: 0.5,
                          backgroundColor: ColorConstant.gray300,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorConstant.orangeA200,
                          ),
                        ),
                      ),
                    ):Container(
                      height: getVerticalSize(
                        8,
                      ),
                      width: getHorizontalSize(
                        311,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.gray300,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            4,
                          ),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            4,
                          ),
                        ),
                        child: LinearProgressIndicator(
                          value: 1,
                          backgroundColor: ColorConstant.gray300,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorConstant.orangeA200,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(  margin: getMargin(
                      top: 28,
                      bottom: 28
                  ),child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Tasks attachment = attatchmentList[index];
                          return ActivitypostCard(attachment);
                        },
                        itemCount: attatchmentList.length,
                      ),
                      attatchmentList.length > 5?  CustomDropDown(
                        focusNode: FocusNode(),
                        icon: Container(
                          margin: getMargin(
                            left: 8,
                            right: 105,
                          ),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgArrowdown,
                          ),
                        ),
                        hintText: "See more",
                        margin: getMargin(
                          top: 12,
                          right: 6,
                        ),
                        onChanged: (value) {},
                      ):Container()
                    ],
                  )),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget ActivitypostCard(Tasks post) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(contentPadding:EdgeInsets.all(0),
        leading: CustomImageView(
          svgPath: ImageConstant.imgMobile,
          height: getSize(
            24,
          ),
          width: getSize(
            24,
          ),
        ),
        title: Text(
          post.name,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppStyle.txtSFProTextMedium14,
        ),
        trailing:  CustomButton(
          height: getVerticalSize(
            30,
          ),
          width: getHorizontalSize(
            94,
          ),
          text:  post.user_status,
        ),
        ),
      ),
    );
  }

  Widget emptyPostWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          text,
          style:
          TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
