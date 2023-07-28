import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';

// ignore: must_be_immutable
class ProjectsWidget extends StatelessWidget {
  ProjectsWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          svgPath: ImageConstant.imgMobile,
          height: getSize(
            24,
          ),
          width: getSize(
            24,
          ),
          margin: getMargin(
            top: 3,
            bottom: 3,
          ),
        ),
        Padding(
          padding: getPadding(
            left: 8,
            top: 7,
            bottom: 5,
          ),
          child: Text(
            "Site Clearing",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextMedium14,
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
            left: 102,
          ),
        ),
      ],
    );
  }
}
