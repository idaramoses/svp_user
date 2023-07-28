import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/app_bar/appbar_circleimage_1.dart';
import 'package:svp_admin_pm/widgets/app_bar/appbar_image.dart';
import 'package:svp_admin_pm/widgets/app_bar/appbar_title.dart';
import 'package:svp_admin_pm/widgets/app_bar/custom_app_bar.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_icon_button.dart';
import 'package:svp_admin_pm/widgets/custom_text_form_field.dart';

class MessagesDetails extends StatelessWidget {
  TextEditingController frame1686560218Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray200,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        height: getVerticalSize(
          108,
        ),
        title: Padding(
          padding: getPadding(
            left: 64,
            top: 56,
            bottom: 12,
          ),
          child: Row(
            children: [
              AppbarCircleimage1(
                imagePath: ImageConstant.imgEllipse1340x40,
              ),
              AppbarTitle(
                text: "Anthony",
                margin: getMargin(
                  left: 12,
                  top: 11,
                  bottom: 8,
                ),
              ),
            ],
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
            svgPath: ImageConstant.imgOverflowmenu,
            margin: getMargin(
              left: 15,
              top: 64,
              right: 15,
              bottom: 20,
            ),
          ),
        ],
        styleType: Style.bgOutlineGray300_1,
      ),
      body: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgFrame1686560644,
              height: getVerticalSize(
                40,
              ),
              width: getHorizontalSize(
                375,
              ),
            ),
            CustomButton(
              height: getVerticalSize(
                24,
              ),
              width: getHorizontalSize(
                96,
              ),
              text: "1st Feb, 2023",
              margin: getMargin(
                top: 8,
              ),
              variant: ButtonVariant.OutlineGray100,
              padding: ButtonPadding.PaddingAll4,
              fontStyle: ButtonFontStyle.SFProTextMedium12Gray800,
              alignment: Alignment.center,
            ),
            Spacer(),
            Padding(
              padding: getPadding(
                left: 16,
              ),
              child: Row(
                children: [
                  CustomImageView(
                    svgPath: ImageConstant.imgArrowrightGray400,
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
                      top: 4,
                      bottom: 2,
                    ),
                    child: Text(
                      "5 attached files from Anthony",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtSFProTextSemibold14Gray400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(
                left: 16,
                top: 8,
                right: 40,
              ),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse1332x32,
                    height: getSize(
                      32,
                    ),
                    width: getSize(
                      32,
                    ),
                    radius: BorderRadius.circular(
                      getHorizontalSize(
                        16,
                      ),
                    ),
                    margin: getMargin(
                      top: 99,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: getMargin(
                        left: 8,
                      ),
                      padding: getPadding(
                        left: 16,
                        top: 6,
                        right: 16,
                        bottom: 6,
                      ),
                      decoration: AppDecoration.outlineGray1002.copyWith(
                        borderRadius: BorderRadiusStyle.customBorderTL16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: getHorizontalSize(
                              225,
                            ),
                            margin: getMargin(
                              right: 21,
                            ),
                            child: Text(
                              "Lorem ipsum dolor sit amet consectetur. Lectus le leo enim quis facilisis. Elit ut facilisi arcu nibh. Etia posuere posuere rhoncus nam. ",
                              maxLines: null,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextRegular16Gray800,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: getPadding(
                                top: 4,
                                bottom: 1,
                              ),
                              child: Text(
                                "12:00",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextMedium12Gray500
                                    .copyWith(
                                  letterSpacing: getHorizontalSize(
                                    0.06,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: getHorizontalSize(
                  287,
                ),
                margin: getMargin(
                  left: 72,
                  top: 12,
                  right: 16,
                  bottom: 16,
                ),
                padding: getPadding(
                  left: 16,
                  top: 6,
                  right: 16,
                  bottom: 6,
                ),
                decoration: AppDecoration.fillOrangeA200.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderTL161,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: getHorizontalSize(
                        243,
                      ),
                      margin: getMargin(
                        right: 11,
                      ),
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur. Lectus leo enim quis facilisis. Elit ut facilisi arcu nibh. E posuere posuere rhoncus nam. Molestie lorem o id sed quis eu ",
                        maxLines: null,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextRegular16WhiteA700,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: getPadding(
                          top: 1,
                          bottom: 1,
                        ),
                        child: Text(
                          "12:00",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style:
                              AppStyle.txtSFProTextMedium12Gray100.copyWith(
                            letterSpacing: getHorizontalSize(
                              0.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        padding: getPadding(
          top: 8,
          bottom: 8,
        ),
        decoration: AppDecoration.outlineGray1003,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomIconButton(
              height: 40,
              width: 40,
              margin: getMargin(
                bottom: 16,
              ),
              variant: IconButtonVariant.OutlineOrangeA200,
              shape: IconButtonShape.CircleBorder20,
              child: CustomImageView(
                svgPath: ImageConstant.imgTrashGray400,
              ),
            ),
            CustomTextFormField(
              width: getHorizontalSize(
                231,
              ),
              focusNode: FocusNode(),
              controller: frame1686560218Controller,
              hintText: "Type here...",
              margin: getMargin(
                top: 2,
                bottom: 18,
              ),
              variant: TextFormFieldVariant.FillGray100,
              fontStyle: TextFormFieldFontStyle.SFProTextRegular16Gray500,
              textInputAction: TextInputAction.done,
            ),
            CustomIconButton(
              height: 40,
              width: 40,
              margin: getMargin(
                bottom: 16,
              ),
              variant: IconButtonVariant.FillOrangeA200,
              shape: IconButtonShape.CircleBorder20,
              child: CustomImageView(
                svgPath: ImageConstant.imgSend,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
