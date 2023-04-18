import '../messages_five_page/widgets/messages_five_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/app_bar/appbar_circleimage.dart';
import 'package:svp_admin_pm/widgets/app_bar/appbar_image.dart';
import 'package:svp_admin_pm/widgets/app_bar/custom_app_bar.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';

// ignore_for_file: must_be_immutable
class MessagesFivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
        body: Column(
          children: [
            Container(
              height: getVerticalSize(
                70,
              ),
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: getMargin(
                              top: 10,
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: ColorConstant.orangeA200,
                            ),
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
                            top: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: getPadding(
                left: 16,
                top: 23,
                right: 16,
                bottom: 23,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Padding(
                    padding: getPadding(
                      right: 1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "MESSAGES",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextBold16,
                            ),
                            Padding(
                              padding: getPadding(
                                top: 19,
                              ),
                              child: Text(
                                "Today",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextSemibold14OrangeA200,
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          height: getVerticalSize(
                            37,
                          ),
                          width: getHorizontalSize(
                            126,
                          ),
                          text: "New Chat",
                          margin: getMargin(
                            top: 11,
                            bottom: 8,
                          ),
                          variant: ButtonVariant.FillOrangeA200,
                          padding: ButtonPadding.PaddingT9,
                          fontStyle: ButtonFontStyle.SFProTextBold14,
                          suffixWidget: Container(
                            margin: getMargin(
                              left: 6,
                            ),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgEdit,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 26,
                    ),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: getVerticalSize(
                            16,
                          ),
                        );
                      },
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return MessagesFiveItemWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
