import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

// ignore: must_be_immutable
class MessagesTwoItemWidget extends StatelessWidget {
  MessagesTwoItemWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.messagesOneScreen);
      },
      child: Container(
        padding: getPadding(
          left: 8,
          top: 10,
          right: 8,
          bottom: 10,
        ),
        decoration: AppDecoration.outlineOrangeA2002,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgEllipse13,
              height: getSize(
                48,
              ),
              width: getSize(
                48,
              ),
              radius: BorderRadius.circular(
                getHorizontalSize(
                  24,
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                left: 16,
                top: 2,
                bottom: 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Anthony",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextSemibold16,
                  ),
                  Padding(
                    padding: getPadding(
                      top: 6,
                    ),
                    child: Text(
                      "Just now",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtSFProTextMedium14Gray500,
                    ),
                  ),
                ],
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
                top: 12,
                bottom: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
