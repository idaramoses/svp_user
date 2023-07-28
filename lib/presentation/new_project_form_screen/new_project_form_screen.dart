import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_radio_button.dart';
import 'package:svp_admin_pm/widgets/custom_text_form_field.dart';

import '../projects_main/state/project_controller.dart';

class NewProjectFormScreen extends StatefulWidget {
  @override
  State<NewProjectFormScreen> createState() => _NewProjectFormScreenState();
}

class _NewProjectFormScreenState extends State<NewProjectFormScreen> {
  TextEditingController name = TextEditingController();

  TextEditingController frame1686560546OneController = TextEditingController();

  TextEditingController frame1686560546TwoController = TextEditingController();

  TextEditingController details =
      TextEditingController();

  TextEditingController sizes = TextEditingController();

  TextEditingController budget = TextEditingController();

  TextEditingController site_location = TextEditingController();

  TextEditingController building_type = TextEditingController();

  String radioGroup = "";

  List<String> radioList = ["lbl_yes", "lbl_no"];

  TextEditingController site_condition = TextEditingController();

  TextEditingController facilities =
      TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool stepone = true;
  bool  isLoading = false;
  String design; //no radio button will be selected
  //String gender = "male"; //if you want to set default value
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
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
                         stepone?  ProjectInfomation():ProjectDetails(),
                        stepone?   Padding(
                          padding: getPadding(
                            left: 16,
                            right: 20,
                            top: 27,
                          ),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                stepone = false;
                              });
                            },
                            child: Padding(
                              padding: getPadding(
                                  top: 10,
                                  bottom: 10
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Next Page",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: AppStyle.txtSFProTextBold16.copyWith(color: Colors.black54),
                                  ),
                                  SizedBox(width: 20,),
                                  Icon(Icons.arrow_forward_ios_sharp,color: Colors.black54)
                                ],
                              ),
                            ),
                          ),
                        ): Padding(
                          padding: getPadding(
                            left: 20,
                            right: 20,
                            top: 27,
                          ),
                          child:  InkWell(
                            onTap: (){
                              setState(() {
                                stepone = true;
                              });
                            },
                            child: Padding(
                              padding: getPadding(
                                top: 10,
                                bottom: 10
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.arrow_back_ios,color: Colors.black54),
                                  SizedBox(width: 20,),
                                  Text(
                                    "Previous Page",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: AppStyle.txtSFProTextBold16.copyWith(color: Colors.black54),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        stepone?Container(): Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: getPadding(
                              left: 38,
                              top: 32,
                              right: 34,
                              bottom: 70,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
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
                                      await ProjectController(context: context).addPost({
                                        "name": name.text,
                                        "due": '2023-12-30T15:08:09+00:00',
                                        "details": details.text,
                                        "size": sizes.text,
                                        "budget": budget.text,
                                        'site_location': site_location.text,
                                        'building_type': building_type.text,
                                        'design': design.toString()??'No',
                                        'site_condition': site_condition.text,
                                        'facilities': facilities.text,
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
        ),
      ),
    );
  }

  Widget ProjectInfomation() {
    return Column(
      crossAxisAlignment : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: getPadding(
            left: 16,
            top: 27,
          ),
          child: Text(
            "NEW PROJECT FORM",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextBold16,
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
            "PROJECT INFORMATION",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16WhiteA700,
          ),
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 16,
          ),
          child: Text(
            "Requested by:",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: name,
          hintText: "User Name",
          margin: getMargin(
            left: 16,
            top: 10,
            right: 16,
          ),
          alignment: Alignment.center,
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 16,
          ),
          child: Text(
            "Project Title (for referencing project):",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: frame1686560546OneController,
          hintText: "Type here...",
          margin: getMargin(
            left: 16,
            top: 10,
            right: 16,
          ),
          padding: TextFormFieldPadding.PaddingT27,
          alignment: Alignment.center,
          maxLines: 4,
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 16,
          ),
          child: Text(
            "When do you need this?",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: frame1686560546TwoController,
          hintText: "Type here...",
          margin: getMargin(
            left: 16,
            top: 10,
            right: 16,
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget ProjectDetails() {
    return Column(
      crossAxisAlignment : CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          margin: getMargin(
            top: 32,
          ),
          padding: getPadding(
            left: 16,
            top: 11,
            right: 16,
            bottom: 11,
          ),
          decoration: AppDecoration.txtFillOrangeA200,
          child: Text(
            "PROJECT DETAILS",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16WhiteA700,
          ),
        ),
        Container(
          width: getHorizontalSize(
            310,
          ),
          margin: getMargin(
            left: 16,
            top: 14,
            right: 48,
          ),
          child: Text(
            "Please provide detailed informaton about \nyour project:",
            maxLines: null,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16Gray800,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: details,
          hintText: "Type here...",
          margin: getMargin(
            left: 16,
            top: 8,
            right: 16,
          ),
          padding: TextFormFieldPadding.PaddingT27,
          alignment: Alignment.center,
          maxLines: 4,
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 15,
          ),
          child: Text(
            "Size of Site:",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: sizes,
          hintText: "Type here...",
          margin: getMargin(
            left: 16,
            top: 11,
            right: 16,
          ),
          alignment: Alignment.center,
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 16,
          ),
          child: Text(
            "Budget:",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: budget,
          hintText: "Type here...",
          margin: getMargin(
            left: 16,
            top: 10,
            right: 16,
          ),
          alignment: Alignment.center,
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 16,
          ),
          child: Text(
            "Building Location:",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: site_location,
          hintText: "Type here...",
          margin: getMargin(
            left: 16,
            top: 10,
            right: 16,
          ),
          padding: TextFormFieldPadding.PaddingT27,
          alignment: Alignment.center,
          maxLines: 4,
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 16,
          ),
          child: Text(
            "Building Type:",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: building_type,
          hintText: "Type here...",
          margin: getMargin(
            left: 16,
            top: 10,
            right: 16,
          ),
          alignment: Alignment.center,
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 16,
          ),
          child: Text(
            "Do you have a Design?",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),


        Padding(
          padding: getPadding(
            left: 16,
            top: 10,
          ),
          child: Row(
            children: [

              Radio(
                value: "Yes",
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
              Text("Yes",   style: AppStyle.txtSFProTextSemibold16,),
              Radio(
                value: "No",
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
              Text("N0",   style: AppStyle.txtSFProTextSemibold16,),
            ],
          ),
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 15,
          ),
          child: Text(
            "What is the Site Condition?",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: site_condition,
          hintText: "Type here...",
          margin: getMargin(
            left: 16,
            top: 11,
            right: 16,
          ),
          padding: TextFormFieldPadding.PaddingT27,
          alignment: Alignment.center,
          maxLines: 4,
        ),
        Padding(
          padding: getPadding(
            left: 16,
            top: 16,
          ),
          child: Text(
            "Facilities surrounding site and on site:",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
        ),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: facilities,
          hintText: "Type here...",
          margin: getMargin(
            left: 16,
            top: 10,
            right: 16,
          ),
          padding: TextFormFieldPadding.PaddingT27,
          textInputAction: TextInputAction.done,
          alignment: Alignment.center,
          maxLines: 4,
        ),
      ],
    );
  }
}
