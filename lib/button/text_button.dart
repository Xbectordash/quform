import 'package:flutter/material.dart';
import 'base_button.dart';

class TextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final double? minWidth;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final Color? decorationColor;

  const TextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height = 40.0,
    this.padding,
    this.textColor,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.minWidth,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.decoration,
    this.decorationColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseButton(
      text: text,
      onPressed: onPressed,
      isFullWidth: isFullWidth,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width,
      height: height,
      borderRadius: 0,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      backgroundColor: Colors.transparent,
      textColor: isDisabled
          ? theme.disabledColor
          : textColor ?? theme.primaryColor,
      elevation: 0,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      textStyle: textStyle?.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: decoration,
            decorationColor: decorationColor,
          ) ??
          theme.textTheme.bodyMedium?.copyWith(
            color: isDisabled
                ? theme.disabledColor
                : textColor ?? theme.primaryColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: decoration,
            decorationColor: decorationColor,
          ),
      minWidth: minWidth,
    );
  }
}
