import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

// ignore: must_be_immutable
class ListbookmarkItemWidget extends StatelessWidget {
  ListbookmarkItemWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(
        top: 8,
        bottom: 8,
      ),
      decoration: AppDecoration.outlineOrangeA2002,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage1,
            height: getVerticalSize(
              75,
            ),
            width: getHorizontalSize(
              101,
            ),
            radius: BorderRadius.circular(
              getHorizontalSize(
                12,
              ),
            ),
          ),
          Padding(
            padding: getPadding(
              top: 9,
              bottom: 9,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
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
                Container(
                  margin: getMargin(
                    top: 8,
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
                          left: 8,
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
                          left: 71,
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
            ),
          ),
        ],
      ),
    );
  }
}
