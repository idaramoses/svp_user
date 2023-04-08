import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

// ignore: must_be_immutable
class DashboardOneItemWidget extends StatelessWidget {
  DashboardOneItemWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(
        left: 16,
        top: 14,
        right: 16,
        bottom: 14,
      ),
      decoration: AppDecoration.outlineOrangeA200.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: getPadding(
              top: 1,
            ),
            child: Row(
              children: [
                CustomImageView(
                  svgPath: ImageConstant.imgMenuOrangeA200,
                  height: getSize(
                    32,
                  ),
                  width: getSize(
                    32,
                  ),
                ),
                CustomImageView(
                  svgPath: ImageConstant.imgArrowright,
                  height: getSize(
                    24,
                  ),
                  width: getSize(
                    24,
                  ),
                  margin: getMargin(
                    left: 80,
                    top: 4,
                    bottom: 4,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: getPadding(
              top: 12,
            ),
            child: Text(
              "Projects",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtSFProTextBold16,
            ),
          ),
          Padding(
            padding: getPadding(
              top: 10,
            ),
            child: Text(
              "7",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtInterSemiBold24,
            ),
          ),
          Container(
            width: getHorizontalSize(
              113,
            ),
            margin: getMargin(
              top: 11,
            ),
            child: Text(
              "You have 7 ongoing Projects.",
              maxLines: null,
              textAlign: TextAlign.left,
              style: AppStyle.txtSFProTextMedium12.copyWith(
                letterSpacing: getHorizontalSize(
                  0.06,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
