import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.prefixWidget,
      this.suffixWidget});

  ButtonShape shape;

  ButtonPadding padding;

  ButtonVariant variant;

  ButtonFontStyle fontStyle;

  Alignment alignment;

  EdgeInsetsGeometry margin;

  VoidCallback onTap;

  double width;

  double height;

  String text;

  Widget prefixWidget;

  Widget suffixWidget;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? SizedBox(),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: _setFontStyle(),
          ),
          suffixWidget ?? SizedBox(),
        ],
      );
    } else {
      return Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: _setFontStyle(),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        width ?? double.maxFinite,
        height ?? getVerticalSize(40),
      ),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      side: _setTextButtonBorder(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingT9:
        return getPadding(
          left: 9,
          top: 9,
          bottom: 9,
        );
      case ButtonPadding.PaddingT8:
        return getPadding(
          top: 8,
          right: 8,
          bottom: 8,
        );
      case ButtonPadding.PaddingAll11:
        return getPadding(
          all: 11,
        );
      case ButtonPadding.PaddingAll4:
        return getPadding(
          all: 4,
        );
      default:
        return getPadding(
          all: 7,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.OutlineGray400:
        return ColorConstant.whiteA700;
      case ButtonVariant.FillOrangeA200:
        return ColorConstant.orangeA200;
      case ButtonVariant.Success:
        return ColorConstant.lightGreenA700;
      case ButtonVariant.FillBlue600:
        return ColorConstant.blue600;
      case ButtonVariant.Error:
        return ColorConstant.red500;
      case ButtonVariant.OutlineGray100:
        return ColorConstant.whiteA700;
      case ButtonVariant.OutlineOrangeA200:
        return null;
      default:
        return ColorConstant.gray500;
    }
  }

  _setTextButtonBorder() {
    switch (variant) {
      case ButtonVariant.OutlineOrangeA200:
        return BorderSide(
          color: ColorConstant.orangeA200,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGray400:
        return BorderSide(
          color: ColorConstant.gray400,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGray100:
        return BorderSide(
          color: ColorConstant.gray100,
          width: getHorizontalSize(
            1.00,
          ),
        );
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.CircleBorder16:
        return BorderRadius.circular(
          getHorizontalSize(
            16.00,
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.SFProTextBold12:
        return TextStyle(
          color: ColorConstant.orangeA200,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.25,
          ),
        );
      case ButtonFontStyle.SFProTextMedium12:
        return TextStyle(
          color: ColorConstant.gray400,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w500,
          height: getVerticalSize(
            1.25,
          ),
        );
      case ButtonFontStyle.SFProTextBold16:
        return TextStyle(
          color: ColorConstant.orangeA200,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.25,
          ),
        );
      case ButtonFontStyle.SFProTextBold16WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.25,
          ),
        );
      case ButtonFontStyle.SFProTextBold14:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.21,
          ),
        );
      case ButtonFontStyle.SFProTextMedium12Gray800:
        return TextStyle(
          color: ColorConstant.gray800,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w500,
          height: getVerticalSize(
            1.25,
          ),
        );
      default:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.25,
          ),
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder8,
  CircleBorder16,
}

enum ButtonPadding {
  PaddingAll7,
  PaddingT9,
  PaddingT8,
  PaddingAll11,
  PaddingAll4,
}

enum ButtonVariant {
  FillGray500,
  OutlineOrangeA200,
  OutlineGray400,
  FillOrangeA200,
  Success,
  FillBlue600,
  Error,
  OutlineGray100,
}

enum ButtonFontStyle {
  SFProTextBold12WhiteA700,
  SFProTextBold12,
  SFProTextMedium12,
  SFProTextBold16,
  SFProTextBold16WhiteA700,
  SFProTextBold14,
  SFProTextMedium12Gray800,
}
