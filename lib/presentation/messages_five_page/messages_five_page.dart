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
        appBar: CustomAppBar(
          height: getVerticalSize(
            100,
          ),
          leadingWidth: 80,
          leading: AppbarImage(
            height: getVerticalSize(
              32,
            ),
            width: getHorizontalSize(
              64,
            ),
            imagePath: ImageConstant.imgSvppnglogo1,
            margin: getMargin(
              left: 16,
              top: 56,
              bottom: 12,
            ),
          ),
          actions: [
            AppbarImage(
              height: getSize(
                24,
              ),
              width: getSize(
                24,
              ),
              svgPath: ImageConstant.imgSearch,
              margin: getMargin(
                left: 16,
                top: 60,
                right: 12,
                bottom: 4,
              ),
            ),
            Container(
              height: getSize(
                24,
              ),
              width: getSize(
                24,
              ),
              margin: getMargin(
                left: 32,
                top: 60,
                right: 12,
                bottom: 4,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  AppbarImage(
                    height: getSize(
                      24,
                    ),
                    width: getSize(
                      24,
                    ),
                    svgPath: ImageConstant.imgNotification,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: getSize(
                        8,
                      ),
                      width: getSize(
                        8,
                      ),
                      margin: getMargin(
                        left: 16,
                        bottom: 16,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.red500,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppbarCircleimage(
              imagePath: ImageConstant.imgEllipse12,
              margin: getMargin(
                left: 32,
                top: 56,
                right: 28,
              ),
            ),
          ],
          styleType: Style.bgOutlineGray300,
        ),
        body: Container(
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
      ),
    );
  }
}
