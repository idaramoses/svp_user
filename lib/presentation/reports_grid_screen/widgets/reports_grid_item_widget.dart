import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

// ignore: must_be_immutable
class ReportsGridItemWidget extends StatelessWidget {
  ReportsGridItemWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgImage1124x166,
          height: getVerticalSize(
            124,
          ),
          width: getHorizontalSize(
            166,
          ),
          radius: BorderRadius.circular(
            getHorizontalSize(
              16,
            ),
          ),
        ),
        Padding(
          padding: getPadding(
            top: 8,
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
              ),
              Padding(
                padding: getPadding(
                  left: 8,
                  top: 3,
                ),
                child: Text(
                  "Foundation.jpg",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextSemibold16,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: getMargin(
            top: 4,
          ),
          decoration: AppDecoration.outlineGray3002,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: getPadding(
                  top: 8,
                ),
                child: Text(
                  "Sent by:",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextSemibold14,
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 4,
                  top: 7,
                ),
                child: Text(
                  "Jane P.",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextMedium14OrangeA200,
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 22,
                  top: 8,
                ),
                child: Text(
                  "16/09",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextMedium14Gray500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
