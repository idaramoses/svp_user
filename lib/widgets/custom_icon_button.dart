import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.width,
      this.height,
      this.child,
      this.onTap});

  IconButtonShape shape;

  IconButtonPadding padding;

  IconButtonVariant variant;

  Alignment alignment;

  EdgeInsetsGeometry margin;

  double width;

  double height;

  Widget child;

  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        visualDensity: VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        iconSize: getSize(height ?? 0),
        padding: EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll12:
        return getPadding(
          all: 12,
        );
      default:
        return getPadding(
          all: 8,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.FillOrangeA200:
        return ColorConstant.orangeA200;
      case IconButtonVariant.OutlineOrangeA200a2_1:
        return ColorConstant.orangeA200A2;
      case IconButtonVariant.FillWhiteA700:
        return ColorConstant.whiteA700;
      case IconButtonVariant.OutlineOrangeA200:
        return null;
      default:
        return ColorConstant.orangeA200A2;
    }
  }

  _setBorder() {
    switch (variant) {
      case IconButtonVariant.OutlineOrangeA200:
        return Border.all(
          color: ColorConstant.orangeA200,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineOrangeA200a2_1:
        return Border.all(
          color: ColorConstant.orangeA200A2,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.FillOrangeA200:
      case IconButtonVariant.FillWhiteA700:
        return null;
      default:
        return Border.all(
          color: ColorConstant.orangeA200A2,
          width: getHorizontalSize(
            1.00,
          ),
        );
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.CircleBorder20:
        return BorderRadius.circular(
          getHorizontalSize(
            20.00,
          ),
        );
      case IconButtonShape.CircleBorder24:
        return BorderRadius.circular(
          getHorizontalSize(
            24.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        );
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case IconButtonVariant.OutlineOrangeA200a2_1:
        return [
          BoxShadow(
            color: ColorConstant.gray80026,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              -2,
              0,
            ),
          )
        ];
      case IconButtonVariant.OutlineOrangeA200:
      case IconButtonVariant.FillOrangeA200:
      case IconButtonVariant.FillWhiteA700:
        return null;
      default:
        return [
          BoxShadow(
            color: ColorConstant.gray80026,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              2,
              0,
            ),
          )
        ];
    }
  }
}

enum IconButtonShape {
  RoundedBorder8,
  CircleBorder20,
  CircleBorder24,
}

enum IconButtonPadding {
  PaddingAll8,
  PaddingAll12,
}

enum IconButtonVariant {
  OutlineOrangeA200a2,
  OutlineOrangeA200,
  FillOrangeA200,
  OutlineOrangeA200a2_1,
  FillWhiteA700,
}
