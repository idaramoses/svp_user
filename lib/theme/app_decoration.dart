import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get outlineOrangeA2003 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.orangeA200,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineOrangeA2002 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border(

        ),
       borderRadius:BorderRadius.circular(
         getHorizontalSize(
           10,
         ),
       )
      );
  static BoxDecoration get fillOrangeA200 => BoxDecoration(
        color: ColorConstant.orangeA200,
      );
  static BoxDecoration get outlineOrangeA2004 => BoxDecoration(
        border: Border.all(
          color: ColorConstant.orangeA200,
          width: getHorizontalSize(
            2,
          ),
        ),
      );
  static BoxDecoration get outlineOrangeA2001 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border(
          left: BorderSide(
            color: ColorConstant.orangeA200,
            width: getHorizontalSize(
              4,
            ),
          ),
        ),
      );
  static BoxDecoration get outlineOrangeA200a2 => BoxDecoration(
        color: ColorConstant.orangeA200A2,
        border: Border.all(
          color: ColorConstant.orangeA200A2,
          width: getHorizontalSize(
            1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray80026,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              2,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineGray3002 => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorConstant.gray300,
            width: getHorizontalSize(
              1,
            ),
          ),
        ),
      );
  static BoxDecoration get outlineGray3001 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.gray300,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineGray3004 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorConstant.gray300,
            width: getHorizontalSize(
              1,
            ),
          ),
        ),
      );
  static BoxDecoration get outlineGray3003 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border(
          left: BorderSide(
            color: ColorConstant.gray300,
            width: getHorizontalSize(
              4,
            ),
          ),
        ),
      );
  static BoxDecoration get outlineGray1003 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border(
          top: BorderSide(
            color: ColorConstant.gray100,
            width: getHorizontalSize(
              1,
            ),
          ),
        ),
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get outlineGray3005 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border(
          top: BorderSide(
            color: ColorConstant.gray300,
            width: getHorizontalSize(
              1,
            ),
          ),
          bottom: BorderSide(
            color: ColorConstant.gray300,
            width: getHorizontalSize(
              1,
            ),
          ),
        ),
      );
  static BoxDecoration get success => BoxDecoration(
        color: ColorConstant.lightGreenA700,
      );
  static BoxDecoration get outlineGray100 => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorConstant.gray100,
            width: getHorizontalSize(
              1,
            ),
          ),
          bottom: BorderSide(
            color: ColorConstant.gray100,
            width: getHorizontalSize(
              1,
            ),
          ),
          right: BorderSide(
            color: ColorConstant.gray100,
            width: getHorizontalSize(
              1,
            ),
          ),
        ),
      );
  static BoxDecoration get outlineGray300 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: ColorConstant.gray300,
            width: getHorizontalSize(
              1,
            ),
          ),
        ),
      );
  static BoxDecoration get outlineOrangeA200 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.orangeA200,
          width: getHorizontalSize(
            1,
          ),
          // strokeAlign: strokeAlignCenter,
        ),
      );
  static BoxDecoration get outlineGray1002 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.gray100,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineGray1001 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border(
          top: BorderSide(
            color: ColorConstant.gray100,
            width: getHorizontalSize(
              1,
            ),
          ),
          bottom: BorderSide(
            color: ColorConstant.gray100,
            width: getHorizontalSize(
              1,
            ),
          ),
        ),
      );
  static BoxDecoration get fillGray500 => BoxDecoration(
        color: ColorConstant.gray500,
      );
  static BoxDecoration get txtFillOrangeA200 => BoxDecoration(
        color: ColorConstant.orangeA200,
      );
  static BoxDecoration get fillGray200 => BoxDecoration(
        color: ColorConstant.gray200,
      );
  static BoxDecoration get fillGray100 => BoxDecoration(
        color: ColorConstant.gray100,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder8 = BorderRadius.circular(
    getHorizontalSize(
      8,
    ),
  );

  static BorderRadius roundedBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12,
    ),
  );

  static BorderRadius roundedBorder24 = BorderRadius.circular(
    getHorizontalSize(
      24,
    ),
  );

  static BorderRadius circleBorder20 = BorderRadius.circular(
    getHorizontalSize(
      20,
    ),
  );

  static BorderRadius customBorderTL16 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        16,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        16,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        16,
      ),
    ),
  );

  static BorderRadius customBorderTL161 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        16,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        16,
      ),
    ),
    bottomLeft: Radius.circular(
      getHorizontalSize(
        16,
      ),
    ),
  );

  static BorderRadius txtCircleBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12,
    ),
  );

  static BorderRadius circleBorder16 = BorderRadius.circular(
    getHorizontalSize(
      16,
    ),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

// double get strokeAlignInside => BorderSide.strokeAlignInside;
//
// double get strokeAlignCenter => BorderSide.strokeAlignCenter;
//
// double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
