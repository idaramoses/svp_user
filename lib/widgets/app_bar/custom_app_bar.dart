import 'package:flutter/material.dart';

import '../../core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar(
      {this.height,
      this.styleType,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions});

  double height;

  Style styleType;

  double leadingWidth;

  Widget leading;

  Widget title;

  bool centerTitle;

  List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: ColorConstant.whiteA700,
      // flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        size.width,
        height,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgOutlineGray300:
        return Container(
          height: getVerticalSize(
            100,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: ColorConstant.whiteA700,
            border: Border(
              bottom: BorderSide(
                color: ColorConstant.gray300,
                width: getHorizontalSize(
                  1,
                ),
              ),
            ),
          ),
        );
      case Style.bgOutlineGray300_1:
        return Container(
          height: getVerticalSize(
            112,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: ColorConstant.whiteA700,
            border: Border(
              bottom: BorderSide(
                color: ColorConstant.gray300,
                width: getHorizontalSize(
                  1,
                ),
              ),
            ),
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgOutlineGray300,
  bgOutlineGray300_1,
}
