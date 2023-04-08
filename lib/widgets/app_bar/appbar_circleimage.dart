import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_decoration.dart';

// ignore: must_be_immutable
class AppbarCircleimage extends StatelessWidget {
  AppbarCircleimage({this.imagePath, this.svgPath, this.margin, this.onTap});

  String imagePath;

  String svgPath;

  EdgeInsetsGeometry margin;

  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadiusStyle.circleBorder16,
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          svgPath: svgPath,
          imagePath: imagePath,
          height: getSize(
            32,
          ),
          width: getSize(
            32,
          ),
          fit: BoxFit.contain,
          radius: BorderRadius.circular(
            getHorizontalSize(
              16,
            ),
          ),
        ),
      ),
    );
  }
}
