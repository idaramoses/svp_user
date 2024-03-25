import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../utils/themes.dart';
import '../model/electricity_model.dart';

// ignore: must_be_immutable
class ElectricityCommon extends StatefulWidget {
  ElectricityCommon({super.key, required this.modelData});

  ElectricityModel modelData;

  @override
  State<ElectricityCommon> createState() => _ElectricityCommonState();
}

class _ElectricityCommonState extends State<ElectricityCommon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonMethods.sendToNextScreen(
          context,
          RoutesPath.maharashtraElectricityPage,
        );
      },
      child: Container(
        height: 75.h,
        decoration: CommonMethods.getBoxDecoration(
          cornerRadius: 12.r,
          color: Themes.getCardColor(context),
        ),
        child: Padding(
          padding: CommonMethods.appPadding(),
          child: Row(
            children: [
              CommonMethods.imagesOfApp(
                widget.modelData.image!,
                height: 54.h,
                width: 54.h,
              ),
              CommonMethods.sizedBox(width: 16.w),
              CommonMethods.appTexts(
                context,
                widget.modelData.title!,
                textAlign: TextAlign.center,
                color: Themes.getTextColor(context),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
