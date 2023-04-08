import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';

// ignore: must_be_immutable
class TasksGridItemWidget extends StatelessWidget {
  TasksGridItemWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(
        left: 10,
        top: 12,
        right: 10,
        bottom: 12,
      ),
      decoration: AppDecoration.outlineOrangeA2003.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                  top: 2,
                  bottom: 4,
                ),
                child: Text(
                  "Naomi SVP",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextSemibold14OrangeA200,
                ),
              ),
              CustomImageView(
                svgPath: ImageConstant.imgOverflowmenuGray800,
                height: getSize(
                  24,
                ),
                width: getSize(
                  24,
                ),
                margin: getMargin(
                  left: 50,
                ),
              ),
            ],
          ),
          Padding(
            padding: getPadding(
              top: 5,
            ),
            child: Text(
              "Site clearing",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtSFProTextSemibold16,
            ),
          ),
          Container(
            width: getHorizontalSize(
              146,
            ),
            margin: getMargin(
              top: 5,
            ),
            child: Text(
              "Site clearing for 6-Bedroom building for Skyline Building construc...",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: AppStyle.txtSFProTextRegular12Gray600,
            ),
          ),
          Padding(
            padding: getPadding(
              top: 5,
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
              top: 7,
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
                    left: 12,
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
