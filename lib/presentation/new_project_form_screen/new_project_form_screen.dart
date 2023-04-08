import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_radio_button.dart';
import 'package:svp_admin_pm/widgets/custom_text_form_field.dart';

class NewProjectFormScreen extends StatelessWidget {
  TextEditingController frame1686560546Controller = TextEditingController();

  TextEditingController frame1686560546OneController = TextEditingController();

  TextEditingController frame1686560546TwoController = TextEditingController();

  TextEditingController frame1686560546ThreeController =
      TextEditingController();

  TextEditingController frame1686560546FourController = TextEditingController();

  TextEditingController frame1686560546FiveController = TextEditingController();

  TextEditingController frame1686560547Controller = TextEditingController();

  TextEditingController frame1686560546SixController = TextEditingController();

  String radioGroup = "";

  List<String> radioList = ["lbl_yes", "lbl_no"];

  TextEditingController frame1686560547OneController = TextEditingController();

  TextEditingController frame1686560546SevenController =
      TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                          height: getVerticalSize(80),
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
                          controller: frame1686560546Controller,
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
                          controller: frame1686560546ThreeController,
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
                          controller: frame1686560546FourController,
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
                          controller: frame1686560546FiveController,
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
                          controller: frame1686560547Controller,
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
                          controller: frame1686560546SixController,
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
                              CustomRadioButton(
                                text: "Yes",
                                iconSize: getHorizontalSize(
                                  24,
                                ),
                                value: radioList[0],
                                groupValue: radioGroup,
                                fontStyle: RadioFontStyle.SFProTextSemibold16,
                                onChange: (value) {
                                  radioGroup = value;
                                },
                              ),
                              CustomRadioButton(
                                text: "No",
                                value: radioList[1],
                                groupValue: radioGroup,
                                margin: getMargin(
                                  left: 24,
                                ),
                                fontStyle: RadioFontStyle.SFProTextSemibold16,
                                onChange: (value) {
                                  radioGroup = value;
                                },
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
                            "What is the Site Condition?",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextSemibold16,
                          ),
                        ),
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: frame1686560547OneController,
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
                          controller: frame1686560546SevenController,
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
                        Align(
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
}
