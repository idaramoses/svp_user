import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 16,
                            top: 24,
                            right: 17,
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
                                  "Site Clearing",
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
                                  74,
                                ),
                                text: "Pending",
                                variant: ButtonVariant.FillBlue600,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: getHorizontalSize(
                          329,
                        ),
                        margin: getMargin(
                          left: 16,
                          top: 14,
                          right: 29,
                        ),
                        child: Text(
                          "Clearing of proposed site for the construction of a 6 storey skyscraper belonging to Dr. James",
                          maxLines: null,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextRegular16Gray800,
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
                                            "02 Feb, 2023",
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
                                          "02 Apr, 2023",
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
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: getHorizontalSize(
                            333,
                          ),
                          margin: getMargin(
                            left: 16,
                            top: 14,
                            right: 25,
                          ),
                          child: Text(
                            "The clearing of the site should be completed by gathering all cut vegetation, stumps, roots and large stones. All these should be removed from the work area. When conditions are dry enough, the clearing can be completed by starting a fire, which should be carefully kept under control.",
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextRegular16Gray800,
                          ),
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
                      Padding(
                        padding: getPadding(
                          left: 16,
                          top: 16,
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
                          161,
                        ),
                        text: "See all Attachments",
                        margin: getMargin(
                          top: 24,
                        ),
                        variant: ButtonVariant.OutlineOrangeA200,
                        fontStyle: ButtonFontStyle.SFProTextBold12,
                        alignment: Alignment.center,
                      ),
                      CustomButton(
                        height: getVerticalSize(
                          43,
                        ),
                        width: getHorizontalSize(
                          232,
                        ),
                        text: "Request Task Approval",
                        margin: getMargin(
                          top: 48,
                          bottom: 68,
                        ),
                        variant: ButtonVariant.FillOrangeA200,
                        padding: ButtonPadding.PaddingAll11,
                        fontStyle: ButtonFontStyle.SFProTextBold16WhiteA700,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
