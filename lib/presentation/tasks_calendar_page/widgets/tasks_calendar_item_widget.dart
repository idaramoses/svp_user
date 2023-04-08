import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';

// ignore: must_be_immutable
class TasksCalendarItemWidget extends StatelessWidget {
  TasksCalendarItemWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(
        left: 16,
        top: 12,
        right: 16,
        bottom: 12,
      ),
      decoration: AppDecoration.outlineGray3001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: getPadding(
                      top: 3,
                    ),
                    child: Text(
                      "Site clearing",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtSFProTextSemibold16,
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
                      left: 8,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: getPadding(
                  top: 7,
                ),
                child: Text(
                  "Due date:",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextSemibold14,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 8,
                ),
                child: Row(
                  children: [
                    CustomImageView(
                      svgPath: ImageConstant.imgCalendar,
                      height: getSize(
                        16,
                      ),
                      width: getSize(
                        16,
                      ),
                      margin: getMargin(
                        bottom: 1,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 8,
                      ),
                      child: Text(
                        "17/01/23",
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
          CustomButton(
            height: getVerticalSize(
              30,
            ),
            width: getHorizontalSize(
              83,
            ),
            text: "Approved",
            margin: getMargin(
              top: 22,
              bottom: 22,
            ),
            variant: ButtonVariant.Success,
          ),
        ],
      ),
    );
  }
}
