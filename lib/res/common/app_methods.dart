import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/themes.dart';
import '../constant/app_strings.dart';

class CommonMethods {
  static sendToNextScreen(BuildContext context, String routes,
      {var arguments}) {
    if (arguments != null) {
      Get.toNamed(routes, arguments: arguments);
    } else {
      Get.toNamed(routes);
    }
  }

  static sendToNextScreenWithoutBack(BuildContext context, String routes,
      {var arguments}) {
    if (arguments != null) {
      Get.offNamed(routes, arguments: arguments);
    } else {
      Get.offNamed(routes);
    }
  }

  static jumpOutFromScreen(BuildContext context) {
    Get.back();
  }

  static nullAppBar(
    BuildContext context, {
    Brightness? statusBarIconBrightness,
    Brightness? statusBarBrightness,
    Color? statusBarColor,
  }) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Themes.getTextColor(context),
      ),
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarBrightness,
      ),
    );
  }

  static appPadding() {
    return EdgeInsets.symmetric(horizontal: 16.w);
  }

  static sizedBox({
    double? height,
    double? width,
    Widget? child,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }

  static imagesOfApp(
    String images, {
    double? height,
    double? width,
    BoxFit? fit,
    Color? color,
  }) {
    return Image.asset(
      images,
      height: height,
      width: width,
      color: color,
      fit: fit,
    );
  }

  static svgImagesOfApp(
    String images, {
    double? height,
    double? width,
    Color? color,
  }) {
    return SvgPicture.asset(
      images,
      height: height,
      width: width,
      color: color,
    );
  }

  static appTexts(
    BuildContext context,
    String text, {
    TextStyle? style,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? height,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style == null
          ? TextStyle(
              color: color ??
                  Themes.getColorsTheme(context)
                      .textTheme
                      .headlineMedium!
                      .color,
              fontWeight: fontWeight,
              fontSize: fontSize,
              height: height,
            )
          : style.copyWith(),
    );
  }

  static appBar({
    Color? backgroundColor,
    Widget? title,
    Function? onTap,
    List<Widget>? actions,
  }) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: false,
      title: title,
      actions: actions,
      leading: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16.h, top: 27.h, bottom: 27.h),
          child:  Icon(Icons.arrow_back_ios_new),
        ),
      ),
      surfaceTintColor: Colors.transparent,
      // iconTheme: const IconThemeData(color: Colors.white),
      toolbarHeight: 65,
    );
  }

  static getBoxDecoration({
    double cornerRadius = 0,
    Color? color,
    Color borderColor = Colors.transparent,
    List<BoxShadow>? shadows,
  }) {
    return ShapeDecoration(
      color: color,
      shadows: shadows,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: cornerRadius,
          cornerSmoothing: 0.5,
        ),
        side: BorderSide(
          color: borderColor,
          width: borderColor == Colors.transparent ? 0 : 1,
        ),
      ),
    );
  }

  static getOnlyDecoration({
    double topLeft = 0,
    double topRight = 0,
    double bottomRight = 0,
    double bottomLeft = 0,
    Color? color,
    Color borderColor = Colors.transparent,
  }) {
    return ShapeDecoration(
        color: color,
        shape: SmoothRectangleBorder(
          side: BorderSide(
            color: borderColor,
            width: borderColor == Colors.transparent ? 0 : 1,
          ),
          borderRadius: SmoothBorderRadius.only(
            topLeft: SmoothRadius(
              cornerRadius: topLeft,
              cornerSmoothing: 0.5,
            ),
            topRight: SmoothRadius(
              cornerRadius: topRight,
              cornerSmoothing: 0.5,
            ),
            bottomLeft: SmoothRadius(
              cornerRadius: bottomLeft,
              cornerSmoothing: 0.5,
            ),
            bottomRight: SmoothRadius(
              cornerRadius: bottomRight,
              cornerSmoothing: 0.5,
            ),
          ),
        ));
  }
}

Widget animationFunction(
  index,
  child, {
  Duration? listAnimation,
  Duration? slideDuration,
  Duration? slideDelay,
}) {
  return AnimationConfiguration.staggeredList(
    position: index,
    duration: listAnimation ?? const Duration(milliseconds: 800),
    child: SlideAnimation(
      duration: slideDuration ?? const Duration(milliseconds: 500),
      delay: slideDelay ?? const Duration(milliseconds: 50),
      child: FadeInAnimation(
        child: child,
      ),
    ),
  );
}
