import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_text_form_field.dart';

class NewProjectFormOneScreen extends StatelessWidget {
  TextEditingController frame1686560546Controller = TextEditingController();

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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(
                              top: 1,
                              bottom: 14,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Requested on:",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFProTextSemibold16,
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 19,
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
                                    top: 56,
                                  ),
                                  child: Text(
                                    "Project:",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextSemibold16,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 45,
                                  ),
                                  child: Text(
                                    "Requested by:",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextSemibold16,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 27,
                                  ),
                                  child: Text(
                                    "Started:",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextSemibold16,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 20,
                                  ),
                                  child: Text(
                                    "Due date:",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextSemibold16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              left: 17,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "4 Feb",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFProTextMedium14Gray600,
                                ),
                                Container(
                                  width: getHorizontalSize(
                                    171,
                                  ),
                                  margin: getMargin(
                                    top: 23,
                                  ),
                                  child: Text(
                                    "Setting out for 6-Bedroom Building Construction for Danjuma Homes.",
                                    maxLines: null,
                                    textAlign: TextAlign.left,
                                    style:
                                    AppStyle.txtSFProTextMedium14Gray6001,
                                  ),
                                ),
                                Container(
                                  width: getHorizontalSize(
                                    166,
                                  ),
                                  margin: getMargin(
                                    top: 21,
                                  ),
                                  child: Text(
                                    "6-Bedroom Building Construction for Danjuma Homes.",
                                    maxLines: null,
                                    textAlign: TextAlign.left,
                                    style:
                                    AppStyle.txtSFProTextMedium14Gray6001,
                                  ),
                                ),
                                Container(
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
                                          "John Doe",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtSFProTextSemibold14OrangeA200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 23,
                                  ),
                                  child: Text(
                                    "3 Feb",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                    AppStyle.txtSFProTextMedium14Gray600,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 23,
                                  ),
                                  child: Text(
                                    "4 Feb",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                    AppStyle.txtSFProTextMedium14Gray600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: getPadding(
                          left: 16,
                          top: 16,
                          right: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            Container(
                              margin: getMargin(
                                left: 23,
                                top: 3,
                                bottom: 3,
                              ),
                              padding: getPadding(
                                all: 6,
                              ),
                              decoration:
                              AppDecoration.outlineOrangeA2004.copyWith(
                                borderRadius:
                                BorderRadiusStyle.roundedBorder12,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: getSize(
                                      12,
                                    ),
                                    width: getSize(
                                      12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.orangeA200,
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                            CustomImageView(
                              svgPath: ImageConstant.imgGlobe,
                              height: getSize(
                                24,
                              ),
                              width: getSize(
                                24,
                              ),
                              margin: getMargin(
                                left: 32,
                                top: 3,
                                bottom: 3,
                              ),
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
                      controller: frame1686560546Controller,
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
