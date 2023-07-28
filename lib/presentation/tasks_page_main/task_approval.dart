import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/tasks_page_main/state/task_controller.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_text_form_field.dart';

class TaskAprovalScreen extends StatefulWidget {
  String id;
  String user_status;
  String comments;
  String request_on;
  String due;
  String star;
  String date;
  String projectName;
  String projectUserID;
  String projectID;
  String taskName;
  String taskID;
  String requestFirstName;
  String requestLastName;
  String requestID;
  String approvalId;
  String requestAvata;

  TaskAprovalScreen(
      {Key key,
        this.id,
        this.user_status,
        this.comments,
        this.request_on,
        this.due,
        this.date,
        this.star,
        this.projectName,
        this.projectUserID,
        this.projectID,
        this.taskName,
        this.taskID,
        this.requestFirstName,
        this.requestLastName,
        this.requestID,
        this.approvalId,
        this.requestAvata,
      })
      : super(key: key);

  @override
  State<TaskAprovalScreen> createState() => _TaskAprovalScreenState();
}

class _TaskAprovalScreenState extends State<TaskAprovalScreen> {
  TextEditingController commentController = TextEditingController();
  String design = 'Approved';
  bool  isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray200,
      resizeToAvoidBottomInset: false,
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
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 27,
                      ),
                      child: Text(
                        "APPROVAL REQUEST",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtInterBold16,
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      margin: getMargin(
                        top: 19,
                      ),
                      padding: getPadding(
                        left: 16,
                        top: 11,
                        right: 16,
                        bottom: 11,
                      ),
                      decoration: AppDecoration.txtFillOrangeA200,
                      child: Text(
                        "APPROVAL INFORMATION",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextSemibold16WhiteA700,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 15,
                        right: 61,
                      ),
                      child: Padding(
                        padding: getPadding(
                          top: 1,
                          bottom: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Requested on:",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextSemibold16,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                   widget.request_on,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextMedium14Gray600,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: getPadding(
                                top: 19,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Task: ",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextSemibold16,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                     widget.taskName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextMedium14Gray600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                top: 56,
                              ),
                              child:   Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Project:",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextSemibold16,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      widget.projectName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextMedium14Gray600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                top: 45,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Requested by:",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextSemibold16,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child:  Container(
                                      margin: getMargin(
                                        top: 24,
                                      ),
                                      decoration:
                                      AppDecoration.fillGray200.copyWith(
                                        borderRadius:
                                        BorderRadiusStyle.circleBorder16,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomImageView(
                                            imagePath: ImageConstant.imgEllipse12,
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
                                              widget.requestFirstName +" "+  widget.requestLastName,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtSFProTextSemibold14OrangeA200,
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
                                top: 27,
                              ),
                              child:  Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Started:",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextSemibold16,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                     widget.date,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextMedium14Gray600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                top: 20,
                              ),
                              child:  Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Due date:",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextSemibold16,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      widget.due,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextMedium14Gray600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      margin: getMargin(
                        top: 24,
                      ),
                      padding: getPadding(
                        left: 16,
                        top: 11,
                        right: 16,
                        bottom: 11,
                      ),
                      decoration: AppDecoration.txtFillOrangeA200,
                      child: Text(
                        "RESPONSE",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextSemibold16WhiteA700,
                      ),
                    ),

                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 10,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: getPadding(
                              top: 4,
                              bottom: 5,
                            ),
                            child: Text(
                              "Status:",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextSemibold16,
                            ),
                          ),
                          Radio(
                            value: "Approved",
                            fillColor: MaterialStateColor.resolveWith((states) => Colors.orange),
                            focusColor: MaterialStateColor.resolveWith((states) => Colors.orange),
                            groupValue: design,
                            onChanged: (value){
                              setState(() {
                                design = value.toString();
                                print(value);
                              });
                            },
                          ),
                          CustomButton(
                            height: getVerticalSize(
                              30,
                            ),
                            width: getHorizontalSize(
                              83,
                            ),
                            text: "Approved",
                            margin: getMargin(
                              left: 12,
                            ),
                            variant: ButtonVariant.Success,
                          ),
                          Radio(
                            value: "Declined",
                            fillColor: MaterialStateColor.resolveWith((states) => Colors.orange),
                            focusColor: MaterialStateColor.resolveWith((states) => Colors.orange),
                            groupValue: design,
                            onChanged: (value){
                              setState(() {
                                design = value.toString();
                                print(value);
                              });
                            },
                          ),
                          CustomButton(
                            height: getVerticalSize(
                              30,
                            ),
                            width: getHorizontalSize(
                              78,
                            ),
                            text: "Declined",
                            margin: getMargin(
                              left: 12,
                            ),
                            variant: ButtonVariant.Error,
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
                        "Comment:",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextSemibold16,
                      ),
                    ),
                    CustomTextFormField(
                      focusNode: FocusNode(),
                      controller: commentController,
                      hintText: "Type here...",
                      margin: getMargin(
                        left: 16,
                        top: 11,
                        right: 16,
                      ),
                      padding: TextFormFieldPadding.PaddingT27,
                      fontStyle: TextFormFieldFontStyle.InterRegular16,
                      textInputAction: TextInputAction.done,
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: getPadding(
                          left: 36,
                          top: 32,
                          right: 36,
                          bottom: 47,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              height: getVerticalSize(
                                43,
                              ),
                              width: getHorizontalSize(
                                104,
                              ),
                              text: "Cancel",
                              variant: ButtonVariant.OutlineOrangeA200,
                              padding: ButtonPadding.PaddingAll11,
                              fontStyle: ButtonFontStyle.SFProTextBold16,
                            ),
                            CustomButton(
                              onTap: () async {
                                Navigator.pop(context);
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await TaskController(context: context, id: widget.id,status: design).addPost({
                                    "status": design.toString(),
                                    'comments': commentController.text??'',
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                              height: getVerticalSize(
                                43,
                              ),
                              width: getHorizontalSize(
                                151,
                              ),
                              text: "Submit Form",
                              variant: ButtonVariant.FillOrangeA200,
                              padding: ButtonPadding.PaddingAll11,
                              fontStyle:
                              ButtonFontStyle.SFProTextBold16WhiteA700,
                            ),
                          ],
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
    );
  }
}
