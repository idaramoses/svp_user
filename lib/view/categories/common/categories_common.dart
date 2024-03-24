import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/common/app_methods.dart';
import '../../../utils/themes.dart';
import '../../home/model/categoires_model.dart';

// ignore: must_be_immutable
class CategoriesCommon extends StatefulWidget {
  CategoriesCommon({super.key, required this.modelData});
  CategoriesModel modelData;

  @override
  State<CategoriesCommon> createState() => _CategoriesCommonState();
}

class _CategoriesCommonState extends State<CategoriesCommon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.modelData.routeKey == null
          ? () {}
          : () {
              CommonMethods.sendToNextScreen(
                  context, widget.modelData.routeKey!);
            },
      child: Column(
        children: [
          Container(
            height: 87.h,
            width: 87.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Themes.getCardColor(context),
            ),
            child: Center(
              child: CommonMethods.imagesOfApp(
                widget.modelData.image!,
                height: 36.h,
                width: 36.h,
              ),
            ),
          ),
          CommonMethods.sizedBox(height: 8.h),
          CommonMethods.appTexts(
            context,
            widget.modelData.title!,
            color: Themes.getTextColor(context),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
