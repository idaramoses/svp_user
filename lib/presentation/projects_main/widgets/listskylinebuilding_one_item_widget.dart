import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';

// ignore: must_be_immutable
class ListskylinebuildingOneItemWidget extends StatelessWidget {
  ListskylinebuildingOneItemWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.projectsScreen);
      },
      child: Container(
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
                                      "Skyline Building\nConstruction",
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
                                  "Sujimoto Companies",
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
                            text: "In Progress",
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
                                            "17/01/23",
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
                                "Assigned to:",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextSemibold14,
                              ),
                            ),
                            Container(
                              width: getSize(
                                30,
                              ),
                              height: getSize(
                                30,
                              ),
                              margin: getMargin(
                                left: 8,
                                top: 17,
                                bottom: 9,
                              ),
                              // padding: getPadding(
                              //   all: 4,
                              // ),
                              decoration:
                                  AppDecoration.txtFillOrangeA200.copyWith(
                                borderRadius:
                                    BorderRadiusStyle.txtCircleBorder12,
                              ),
                              child: Center(
                                child: Text(
                                  "JA",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFProTextMedium12WhiteA700
                                      .copyWith(
                                          letterSpacing: getHorizontalSize(
                                            0.06,
                                          ),
                                          fontSize: 12),
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
    );
  }
}