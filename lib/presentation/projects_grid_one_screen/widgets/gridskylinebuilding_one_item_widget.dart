import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';

// ignore: must_be_immutable
class GridskylinebuildingOneItemWidget extends StatelessWidget {
  GridskylinebuildingOneItemWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(
        all: 10,
      ),
      decoration: AppDecoration.outlineOrangeA2003.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: getHorizontalSize(
              120,
            ),
            child: Text(
              "Skyline Building \nConstruction",
              maxLines: null,
              textAlign: TextAlign.left,
              style: AppStyle.txtSFProTextSemibold16Gray800,
            ),
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
          Padding(
            padding: getPadding(
              top: 11,
            ),
            child: Row(
              children: [
                Padding(
                  padding: getPadding(
                    top: 5,
                    bottom: 3,
                  ),
                  child: Text(
                    "Assigned to:",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextBold12Gray500.copyWith(
                      letterSpacing: getHorizontalSize(
                        0.06,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: getSize(
                    24,
                  ),
                  margin: getMargin(
                    left: 11,
                  ),
                  padding: getPadding(
                    all: 4,
                  ),
                  decoration: AppDecoration.txtFillOrangeA200.copyWith(
                    borderRadius: BorderRadiusStyle.txtCircleBorder12,
                  ),
                  child: Text(
                    "JA",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextMedium12WhiteA700.copyWith(
                      letterSpacing: getHorizontalSize(
                        0.06,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: getPadding(
              top: 12,
            ),
            child: Row(
              children: [
                Padding(
                  padding: getPadding(
                    top: 7,
                    bottom: 7,
                  ),
                  child: Text(
                    "Status:",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextBold12Gray500.copyWith(
                      letterSpacing: getHorizontalSize(
                        0.06,
                      ),
                    ),
                  ),
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
                    left: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: getPadding(
              top: 11,
            ),
            child: Row(
              children: [
                Padding(
                  padding: getPadding(
                    bottom: 1,
                  ),
                  child: Text(
                    "Due:",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextBold12Gray500.copyWith(
                      letterSpacing: getHorizontalSize(
                        0.06,
                      ),
                    ),
                  ),
                ),
                CustomImageView(
                  svgPath: ImageConstant.imgCalendar,
                  height: getSize(
                    16,
                  ),
                  width: getSize(
                    16,
                  ),
                  margin: getMargin(
                    left: 11,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 8,
                    top: 1,
                  ),
                  child: Text(
                    "17/01/23",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextMedium12Gray500.copyWith(
                      letterSpacing: getHorizontalSize(
                        0.06,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: getPadding(
              top: 12,
              bottom: 1,
            ),
            child: Row(
              children: [
                Padding(
                  padding: getPadding(
                    top: 5,
                    bottom: 3,
                  ),
                  child: Text(
                    "Priority:",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextBold12Gray500.copyWith(
                      letterSpacing: getHorizontalSize(
                        0.06,
                      ),
                    ),
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
                    left: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
