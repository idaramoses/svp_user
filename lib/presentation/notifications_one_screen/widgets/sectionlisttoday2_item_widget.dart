import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

// ignore: must_be_immutable
class Sectionlisttoday2ItemWidget extends StatelessWidget {
  Sectionlisttoday2ItemWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        top: 2,
        bottom: 2,
      ),
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "New",
                          style: TextStyle(
                            color: ColorConstant.gray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: " ",
                          style: TextStyle(
                            color: ColorConstant.gray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "message",
                          style: TextStyle(
                            color: ColorConstant.gray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: " ",
                          style: TextStyle(
                            color: ColorConstant.gray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "from",
                          style: TextStyle(
                            color: ColorConstant.gray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: " ",
                          style: TextStyle(
                            color: ColorConstant.gray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "Anthony",
                          style: TextStyle(
                            color: ColorConstant.gray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: getPadding(
                      top: 6,
                    ),
                    child: Text(
                      "Just now",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtSFProTextRegular14Gray500,
                    ),
                  ),
                ],
              ),
            ),
            CustomImageView(
              svgPath: ImageConstant.imgOverflowmenu,
              height: getSize(
                24,
              ),
              width: getSize(
                24,
              ),
              margin: getMargin(
                left: 24,
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
