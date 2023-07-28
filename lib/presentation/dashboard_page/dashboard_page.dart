import 'package:animated_horizontal_calendar/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/auth/signin/state/auth_provider.dart';
import 'package:svp_admin_pm/presentation/dashboard_page/widgets/tasks_widget.dart';
import 'package:svp_admin_pm/presentation/messages_screen/state/messages_service.dart';
import 'package:svp_admin_pm/presentation/projects_main/state/project_service.dart';
import 'package:svp_admin_pm/presentation/reports_page/state/report_service.dart';
import 'package:svp_admin_pm/presentation/tasks_page_main/state/task_service.dart';
import 'package:svp_admin_pm/widgets/custom_drop_down.dart';

import '../../models/tasks.dart';
import '../../widgets/custom_button.dart';
import '../main_dashboard/user_dashboard.dart';
import '../messages_screen/state/messages_controller.dart';
import '../messages_screen/state/messages_provider.dart';
import '../tasks_page_main/state/task_controller.dart';
import '../tasks_page_main/state/task_provider.dart';
import '../tasks_page_main/task_details_screen/task_details_screen.dart';

var role;

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final scrollController = ScrollController();
  bool isLoading = false;
  bool loadingMore = false;
  bool isInit = false;
  var messagelenght = '...';
  var Reportlenght = '...';
  var Projectlenght ='...';
  var Tasklenght ='...';

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isInit) {
      await TaskController(context: context).getPosts();
      getPostsLength();
      getReportLength();
      getTasksLength();
      getProjectength();
      setState(() {
        isInit = true;
      });
    }
  }
  Future<int> getPostsLength() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;

    try {

      {
        Map<String, dynamic> response = await Messageservice().getPMnotification();
        if (response["status"] == "success") {
          List posts = List<Map<String, dynamic>>.from(response["body"]);
          setState(() {
            messagelenght =  '${posts.length}';
          });
          return posts.length;
        } else {
          return 0;
        }
      }

    } catch (e) {
      context.read<MessagesProvider>().posts = [];
      print(e);
    }

  }
  Future<int> getReportLength() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;

    try {
      {
        Map<String, dynamic> response = await ReportService().getPMProject();
        if (response["status"] == "success") {
          List posts = List<Map<String, dynamic>>.from(response["body"]);
          setState(() {
            Reportlenght = '${posts.length}';
          });
          return posts.length;
        } else {
          return 0;
        }
      }

    } catch (e) {
      context.read<MessagesProvider>().posts = [];
      print(e);
    }

  }
  Future<int> getTasksLength() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;

    try {
      {
        Map<String, dynamic> response = await TaskService().getPMTasks();
        if (response["status"] == "success") {
          List posts = List<Map<String, dynamic>>.from(response["body"]);
          setState(() {
            Tasklenght = '${posts.length}';
          });
          return posts.length;
        } else {
          return 0;
        }
      }

    } catch (e) {
      context.read<MessagesProvider>().posts = [];
      print(e);
    }

  }
  Future<int> getProjectength() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;

    try {
      {
        Map<String, dynamic> response = await ProjectService().getPMProject();
        if (response["status"] == "success") {
          List posts = List<Map<String, dynamic>>.from(response["body"]);
          setState(() {
            Projectlenght =  '${posts.length}';
          });
          return posts.length;
        } else {
          return 0;
        }
      }

    } catch (e) {
      context.read<MessagesProvider>().posts = [];
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, valuee, child) {
      if (valuee.posts == null)
        return loader();
      else {
        return Consumer<AuthProvider>(
          builder: (context, value, child) => Scaffold(
            backgroundColor: ColorConstant.gray200,
            body: SizedBox(
              width: size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(
                    left: 16,
                    top: 23,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "DASHBOARD",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextBold16,
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 7,
                                ),
                                child: Text(
                                  'Hello ' +
                                      value.userInfo.firstName +
                                      " " +
                                      value.userInfo.lastName +
                                      "!" ??
                                      '...',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFProTextSemibold14,
                                ),
                              ),
                            ],
                          ),
                          value.userInfo.role == 'Admin'
                              ? CustomButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.newProjectFormScreen);
                            },
                            height: getVerticalSize(
                              37,
                            ),
                            width: getHorizontalSize(
                              150,
                            ),
                            text: "Add New Project",
                            margin: getMargin(
                              top: 11,
                              bottom: 8,
                            ),
                            variant: ButtonVariant.FillOrangeA200,
                            padding: ButtonPadding.PaddingT9,
                            fontStyle: ButtonFontStyle.SFProTextBold14,
                            suffixWidget: Container(
                              margin: getMargin(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          )
                              : Container()
                        ],
                      ),
                      Padding(
                        padding: getPadding(
                          top: 24,
                        ),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>MainDashboardScreen(id: 1)));
                              },
                              child: Container(
                                padding: getPadding(
                                  left: 16,
                                  top: 14,
                                  right: 16,
                                  bottom: 14,
                                ),
                                decoration:
                                AppDecoration.outlineOrangeA200.copyWith(
                                  borderRadius: BorderRadiusStyle.circleBorder16,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        top: 1,
                                      ),
                                      child: Row(
                                        children: [
                                          CustomImageView(
                                            svgPath:
                                            ImageConstant.imgComputerGray500,
                                            color: ColorConstant.orangeA200,
                                            height: getSize(
                                              32,
                                            ),
                                            width: getSize(
                                              32,
                                            ),
                                          ),
                                          CustomImageView(
                                            svgPath: ImageConstant.imgArrowright,
                                            height: getSize(
                                              24,
                                            ),
                                            width: getSize(
                                              24,
                                            ),
                                            margin: getMargin(
                                              left: 80,
                                              top: 4,
                                              bottom: 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 12,
                                      ),
                                      child: Text(
                                        "Projects",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtSFProTextBold16,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 10,
                                      ),
                                      child: Text(
                                        Projectlenght.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtInterSemiBold24,
                                      ),
                                    ),
                                    Container(
                                      width: getHorizontalSize(
                                        113,
                                      ),
                                      margin: getMargin(
                                        top: 11,
                                      ),
                                      child: Text(
                                        "You have 7 ongoing Projects.",
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style:
                                        AppStyle.txtSFProTextMedium12.copyWith(
                                          letterSpacing: getHorizontalSize(
                                            0.06,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>MainDashboardScreen(id: 3)));
                              },
                              child: Container(
                                padding: getPadding(
                                  left: 16,
                                  top: 14,
                                  right: 16,
                                  bottom: 14,
                                ),
                                decoration: AppDecoration.outlineOrangeA200.copyWith(
                                  borderRadius: BorderRadiusStyle.circleBorder16,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        top: 1,
                                      ),
                                      child: Row(
                                        children: [
                                          CustomImageView(
                                            svgPath: ImageConstant.imgMailGray500,
                                            color: ColorConstant.orangeA200,
                                            height: getSize(
                                              32,
                                            ),
                                            width: getSize(
                                              32,
                                            ),
                                          ),
                                          CustomImageView(
                                            svgPath: ImageConstant.imgArrowright,
                                            height: getSize(
                                              24,
                                            ),
                                            width: getSize(
                                              24,
                                            ),
                                            margin: getMargin(
                                              left: 80,
                                              top: 4,
                                              bottom: 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 12,
                                      ),
                                      child: Text(
                                        "Report",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtSFProTextBold16,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 10,
                                      ),
                                      child: Text(
                                        Reportlenght.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtInterSemiBold24,
                                      ),
                                    ),
                                    Container(
                                      width: getHorizontalSize(
                                        113,
                                      ),
                                      margin: getMargin(
                                        top: 11,
                                      ),
                                      child: Text(
                                        "You have 7 new report.",
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtSFProTextMedium12.copyWith(
                                          letterSpacing: getHorizontalSize(
                                            0.06,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>MainDashboardScreen(id: 4)));

                              },
                              child: Container(
                                padding: getPadding(
                                  left: 16,
                                  top: 14,
                                  right: 16,
                                  bottom: 14,
                                ),
                                decoration:
                                AppDecoration.outlineOrangeA200.copyWith(
                                  borderRadius: BorderRadiusStyle.circleBorder16,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        top: 1,
                                      ),
                                      child: Row(
                                        children: [
                                          CustomImageView(
                                            svgPath:
                                            ImageConstant.imgMailGray50024x24,
                                            color: ColorConstant.orangeA200,
                                            height: getSize(
                                              32,
                                            ),
                                            width: getSize(
                                              32,
                                            ),
                                          ),
                                          CustomImageView(
                                            svgPath: ImageConstant.imgArrowright,
                                            height: getSize(
                                              24,
                                            ),
                                            width: getSize(
                                              24,
                                            ),
                                            margin: getMargin(
                                              left: 80,
                                              top: 4,
                                              bottom: 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 12,
                                      ),
                                      child: Text(
                                        "Messages",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtSFProTextBold16,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 10,
                                      ),
                                      child: Text(
                                        messagelenght.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtInterSemiBold24,
                                      ),
                                    ),
                                    Container(
                                      width: getHorizontalSize(
                                        113,
                                      ),
                                      margin: getMargin(
                                        top: 11,
                                      ),
                                      child: Text(
                                        "You have 4 new messages.",
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style:
                                        AppStyle.txtSFProTextMedium12.copyWith(
                                          letterSpacing: getHorizontalSize(
                                            0.06,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>MainDashboardScreen(id: 2)));
                              },
                              child: CustomDropDown(
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
                            ),
                          ],
                        ),
                      ),
                      ProjectBody(valuee),
                      Container(height: 0,width: 0, child: TaskWidget()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
  }
  Widget ProjectBody(TaskProvider valuee) {
    if (valuee.posts == null) {
      return loader();
    } else if (valuee.posts.length == 0) {
      emptyPostWidget("No Task.");
    } else {
      List<Tasks> categoryPost = [];
      //List<Post> postsByClassmates = [];

      //get user groups ids

      //get post by category
      valuee.posts.forEach((element) {
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
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Tasks post = postList[index];
        return postCard(post);
      },
      itemCount: postList.length > 3?3:postList.length,
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
