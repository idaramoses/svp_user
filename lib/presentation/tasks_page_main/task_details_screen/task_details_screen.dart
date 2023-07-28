import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/projects_main/projects_details_screen/widgets/projects_widget.dart';
import 'package:svp_admin_pm/presentation/tasks_page_main/task_details_screen/widgets/upload.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_checkbox.dart';
import 'package:svp_admin_pm/widgets/custom_drop_down.dart';

import '../../../models/post.dart';
import '../../../models/tasks.dart';
import '../../auth/signin/state/auth_provider.dart';
import '../../main_dashboard/user_dashboard.dart';
import '../state/task_controller.dart';

class TasksDetailsScreen extends StatefulWidget {
  String id;
  String user_status;
  String name;
  String size;
  String due;
  bool star;
  String date;
  String projectName;
  String projectUserID;
  String projectID;
  String assignFirstName;
  String assignLastName;
  String assignID;
  String approvalId;
  String assignAvata;
  List<TasksAttatment> attachment = [];
  TasksDetailsScreen(
      {Key key,
        this.id,
        this.user_status,
        this.name,
        this.size,
        this.due,
        this.date,
        this.star,
        this.projectName,
        this.projectUserID,
        this.projectID,
        this.assignFirstName,
        this.assignLastName,
        this.assignID,
        this.approvalId,
        this.assignAvata,
        this.attachment,})
      : super(key: key);

  @override
  State<TasksDetailsScreen> createState() => _TasksDetailsScreenState();
}

class _TasksDetailsScreenState extends State<TasksDetailsScreen> {
  int currentIndex = 0;

  bool checkbox = false;
  bool isallatachment = false;

  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];
  final ImagePicker imgpicker = ImagePicker();
  List<XFile> imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles != null){
        imagefiles = pickedfiles;
        setState(() {
        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }
  Future<bool> _willPopCallback() async {
    // exit(0);
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>MainDashboardScreen(id: 2)));
    // return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
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
                              top: 24,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    top: 4,
                                    bottom: 3,
                                  ),
                                  child: Text(
                                    widget.name,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextSemibold18Gray800,
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
                                    top: 3,
                                    bottom: 3,
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
                                  variant: widget.user_status == 'Approved'? ButtonVariant.Success:widget.user_status == 'Declined'? ButtonVariant.Error:ButtonVariant.FillGray500,
                                  text: widget.user_status,
                                  margin: getMargin(
                                    top: 17,
                                    bottom: 17,
                                  ),
                                ),
                                // CustomButton(
                                //   height: getVerticalSize(
                                //     30,
                                //   ),
                                //   width: getHorizontalSize(
                                //     135,
                                //   ),
                                //   text: widget.user_status,
                                //   variant: ButtonVariant.FillBlue600,
                                // ),
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
                            widget.name,
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
                        Padding(
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
                        Container(
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
                            "Instruction:",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextSemibold16,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 16,
                            top: 23,
                            right: 35,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: getPadding(
                                  top: 6,
                                  bottom: 7,
                                ),
                                child: Text(
                                  "Attachments:",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtInterSemiBold16,
                                ),
                              ),
                              CustomButton(
                                onTap: (){

                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(height:MediaQuery.of(context).size.height *1, child: AddEditArticle(
                                          id: widget.id
                                      ));
                                    },
                                  );
                                },
                                height: getVerticalSize(
                                  34,
                                ),
                                width: getHorizontalSize(
                                  175,
                                ),
                                text: "Upload Attachment",
                                variant: ButtonVariant.FillOrangeA200,
                                padding: ButtonPadding.PaddingT9,
                                suffixWidget: Container(
                                  margin: getMargin(
                                    left: 6,
                                  ),
                                  child: CustomImageView(
                                    svgPath: ImageConstant.imgUpload,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: getMargin(
                            top: 48,
                          ),
                          child: ProjectBody(),
                        ),


                        // Provider.of<AuthProvider>(context, listen: false).userInfo.role == 'Admin'?   Column(
                        //   children: [
                        // widget.user_status == "Approved"?Container(height: getVerticalSize(43),):    CustomButton(
                        //       onTap: (){
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //             builder: (context) => Taskloader(
                        //               id:widget.approvalId,
                        //
                        //             )));
                        //       },
                        //       height: getVerticalSize(
                        //         43,
                        //       ),
                        //       width: getHorizontalSize(
                        //         223,
                        //       ),
                        //       text: "Review Task Approval",
                        //       variant: ButtonVariant.FillOrangeA200,
                        //       margin: getMargin(
                        //         top: 48,
                        //         bottom: 68,
                        //       ),
                        //       fontStyle: ButtonFontStyle.SFProTextBold16WhiteA700,
                        //       alignment: Alignment.center,
                        //     ),
                        //   ],
                        // ):
                        // Column(
                        //   children: [
                        //     widget.user_status == "Approved" ?Container(height: getVerticalSize(43),):    CustomButton(
                        //       height: getVerticalSize(
                        //         43,
                        //       ),
                        //       width: getHorizontalSize(
                        //         223,
                        //       ),
                        //       text: "Request Approval",
                        //       margin: getMargin(
                        //         top: 48,
                        //         bottom: 68,
                        //       ),
                        //       variant: ButtonVariant.FillOrangeA200,
                        //       fontStyle: ButtonFontStyle.SFProTextBold16WhiteA700,
                        //       alignment: Alignment.center,
                        //     ),
                        //   ],
                        // ),
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

  Widget ProjectBody() {
    if (widget.attachment == null) {
      return  Center(child: emptyPostWidget("No Attachment."));
    } else if (widget.attachment.length == 0) {
      Center(child: emptyPostWidget("No Attachment."));
    } else {
      //List<Post> postsByClassmates = [];
      List<TasksAttatment> categoryPost = [];
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

  Widget listViewBuilder(List<TasksAttatment> attatchmentList) {
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
              TasksAttatment attachment = attatchmentList[index];
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
          SizedBox(height: getVerticalSize(50),)
        ],
      ),
    );
  }

  Widget postCard(TasksAttatment post) {
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
class Taskloader extends StatefulWidget {
  String id;
  String type;
  Taskloader({Key key,this.id,
    this.type,}) : super(key: key, );

  @override
  State<Taskloader> createState() => _TaskloaderState();
}

class _TaskloaderState extends State<Taskloader> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    next();
  }
  Widget loader() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return PKCardSkeleton();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Column(
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
        Expanded(child: loader()),
      ],
    )));
  }
  Future<void> next() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;
    String mainrole;
    if(role == 'Admin'){
      setState(() {
        mainrole = 'admin';
      });
    }else{
      setState(() {
        mainrole = 'pm';
      });
    }
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        Map<String, dynamic> credentials = {
          "id":  widget.id,
          "role": mainrole,
        };
        await TaskController(context: context).getapproval(credentials);
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }

  }
}