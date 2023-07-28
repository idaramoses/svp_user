import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_checkbox.dart';
import 'package:svp_admin_pm/widgets/custom_radio_button.dart';
import 'package:svp_admin_pm/widgets/custom_text_form_field.dart';

class UploadReportsScreen extends StatelessWidget {
  String radioGroup = "";

  List<String> radioList = [
    "lbl_site_clearing",
    "lbl_site_hoarding",
    "msg_plant_procurement",
    "msg_sand_procurement",
    "msg_cement_procurement"
  ];

  bool checkbox = false;

  bool checkbox1 = false;

  TextEditingController frame1686560547Controller = TextEditingController();

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
                                      top: 44,
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
                                    top: 44,
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
                        top: 24,
                        right: 33,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: getHorizontalSize(
                              158,
                            ),
                            padding: getPadding(
                              left: 8,
                              top: 3,
                              right: 8,
                              bottom: 3,
                            ),
                            decoration:
                            AppDecoration.outlineGray3001.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder8,
                            ),
                            child: Row(
                              children: [
                                CustomImageView(
                                  svgPath: ImageConstant.imgFile,
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
                                ),
                                Padding(
                                  padding: getPadding(
                                    left: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Site Clearing.pdf",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtSFProTextMedium14,
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 2,
                                        ),
                                        child: Text(
                                          "2 MB",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                          AppStyle.txtSFProTextRegular12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
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
                            decoration:
                            AppDecoration.outlineGray3001.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder8,
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
                                  margin: getMargin(
                                    top: 5,
                                    bottom: 5,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    left: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Site Clearing.jpg",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtSFProTextMedium14,
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 2,
                                        ),
                                        child: Text(
                                          "2 MB",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                          AppStyle.txtSFProTextRegular12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      height: getVerticalSize(
                        34,
                      ),
                      width: getHorizontalSize(
                        137,
                      ),
                      text: "Add New File",
                      margin: getMargin(
                        left: 107,
                        top: 24,
                      ),
                      variant: ButtonVariant.OutlineOrangeA200,
                      padding: ButtonPadding.PaddingT9,
                      fontStyle: ButtonFontStyle.SFProTextBold12,
                      suffixWidget: Container(
                        margin: getMargin(
                          left: 6,
                        ),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgPlus,
                        ),
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 23,
                      ),
                      child: Text(
                        "Task:",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextSemibold16,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 15,
                      ),
                      child: Column(
                        children: [
                          CustomRadioButton(
                            text: "Site clearing",
                            iconSize: getHorizontalSize(
                              24,
                            ),
                            value: radioList[0],
                            groupValue: radioGroup,
                            margin: getMargin(
                              right: 65,
                            ),
                            fontStyle: RadioFontStyle.SFProTextRegular16,
                            onChange: (value) {
                              radioGroup = value;
                            },
                          ),
                          CustomRadioButton(
                            text: "Site hoarding",
                            value: radioList[1],
                            groupValue: radioGroup,
                            margin: getMargin(
                              top: 16,
                              right: 59,
                            ),
                            fontStyle: RadioFontStyle.SFProTextRegular16,
                            onChange: (value) {
                              radioGroup = value;
                            },
                          ),
                          CustomRadioButton(
                            text: "Plant procurement",
                            value: radioList[2],
                            groupValue: radioGroup,
                            margin: getMargin(
                              top: 16,
                              right: 20,
                            ),
                            fontStyle: RadioFontStyle.SFProTextRegular16,
                            onChange: (value) {
                              radioGroup = value;
                            },
                          ),
                          CustomRadioButton(
                            text: "Sand procurement",
                            value: radioList[3],
                            groupValue: radioGroup,
                            margin: getMargin(
                              top: 16,
                              right: 20,
                            ),
                            fontStyle: RadioFontStyle.SFProTextRegular16,
                            onChange: (value) {
                              radioGroup = value;
                            },
                          ),
                          CustomRadioButton(
                            text: "Cement procurement",
                            value: radioList[4],
                            groupValue: radioGroup,
                            margin: getMargin(
                              top: 16,
                            ),
                            fontStyle: RadioFontStyle.SFProTextRegular16,
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
                        top: 24,
                        right: 74,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: getPadding(
                              top: 5,
                              bottom: 6,
                            ),
                            child: Text(
                              "Send to:",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextSemibold16,
                            ),
                          ),
                          CustomButton(
                            height: getVerticalSize(
                              32,
                            ),
                            width: getHorizontalSize(
                              146,
                            ),
                            text: "Search Clients...",
                            variant: ButtonVariant.OutlineGray400,
                            shape: ButtonShape.CircleBorder16,
                            padding: ButtonPadding.PaddingT8,
                            fontStyle: ButtonFontStyle.SFProTextMedium12,
                            prefixWidget: Container(
                              margin: getMargin(
                                right: 6,
                              ),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgSearchGray500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomCheckbox(
                      text: "Anthony",
                      value: checkbox,
                      margin: getMargin(
                        left: 16,
                        top: 16,
                      ),
                      fontStyle: CheckboxFontStyle.SFProTextRegular16,
                      onChange: (value) {
                        checkbox = value;
                      },
                    ),
                    CustomCheckbox(
                      text: "Anthony",
                      value: checkbox1,
                      margin: getMargin(
                        left: 16,
                        top: 16,
                      ),
                      fontStyle: CheckboxFontStyle.SFProTextRegular16,
                      onChange: (value) {
                        checkbox1 = value;
                      },
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 16,
                      ),
                      child: Row(
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgMobile,
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
                              "Annabelle",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextRegular16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 16,
                      ),
                      child: Row(
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgMobile,
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
                              "Annabelle",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextRegular16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 16,
                      ),
                      child: Row(
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgMobile,
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
                              "Amara",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextRegular16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 16,
                      ),
                      child: Row(
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgMobile,
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
                              "Amara",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextRegular16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 31,
                      ),
                      child: Text(
                        "Note:",
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
                        top: 11,
                        right: 16,
                      ),
                      padding: TextFormFieldPadding.PaddingT27,
                      textInputAction: TextInputAction.done,
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: getPadding(
                          left: 43,
                          top: 32,
                          right: 43,
                          bottom: 104,
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
                                137,
                              ),
                              text: "Share Files",
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
