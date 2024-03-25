import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/themes.dart';

class AppTextFieldScreen extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? isDense;
  final String? hintText;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? filled;
  final Widget? label;
  final int? maxLines;
  final bool readOnly;
  final Color labelColor;
  final Function()? onTap;
  final bool borderColor;
  final List<TextInputFormatter>? inputFormatter;
  final FocusNode? focusNode;

  const AppTextFieldScreen({
    super.key,
    this.controller,
    this.keyboardType,
    this.textCapitalization,
    this.textInputType,
    this.obscureText,
    this.isDense,
    this.hintText,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.filled,
    this.inputFormatter,
    this.label,
    this.maxLines,
    this.readOnly = false,
    this.onTap,
    this.labelColor = Colors.transparent,
    this.borderColor = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier isValue = ValueNotifier(controller!.text.isNotEmpty);
    return ValueListenableBuilder(
      valueListenable: isValue,
      builder: (context, value, child) {
        debugPrint("value===${isValue.value}");
        return TextFormField(
          controller: controller,
          showCursor: true,
          style: TextStyle(
            color: Themes.getTextColor(context),
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
          ),
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          autocorrect: false,
          autofocus: false,
          maxLines: maxLines,
          readOnly: readOnly,
          inputFormatters: inputFormatter,
          keyboardType: textInputType ?? TextInputType.name,
          textAlign: TextAlign.start,
          textCapitalization: textCapitalization ?? TextCapitalization.words,
          textInputAction: keyboardType ?? TextInputAction.done,
          validator: validator,
          textAlignVertical: TextAlignVertical.center,
          obscureText: obscureText ?? false,
          obscuringCharacter: '•',
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
            if (value.isNotEmpty) {
              isValue.value = true;
            } else {
              isValue.value = false;
            }
          },
          decoration: InputDecoration(
            label: isValue.value ? label : const SizedBox(),
            labelStyle: TextStyle(
              color: Themes.getTextColor(context),
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
            ),
            hintText: hintText ?? "",
            hintStyle: TextStyle(
              color: const Color(0xFFACAFB5),
              height: 1.5,
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelStyle: TextStyle(
              color: Themes.getTextColor(context),
              fontSize: 11.sp,
              fontWeight: FontWeight.w300,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                borderSide: const BorderSide(
                  color: Color(0xFFC5C5C5),
                  style: BorderStyle.solid,
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
              borderSide: const BorderSide(
                color: Color(0xFFC5C5C5),
                style: BorderStyle.solid,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
              borderSide: const BorderSide(
                color: Colors.red,
                style: BorderStyle.solid,
              ),
            ),
            suffixIcon: isValue.value
                ? suffixIcon ?? const SizedBox()
                : const SizedBox(),
            prefixIcon: prefixIcon,
          ),
        );
      },
    );
  }
}
