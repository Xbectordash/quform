import 'package:flutter/material.dart';
import 'base_button.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? elevation;
  final TextStyle? textStyle;
  final double? minWidth;
  final Gradient? gradient;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = true,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height = 48.0,
    this.borderRadius = 24.0,
    this.padding,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.elevation = 0,
    this.textStyle,
    this.minWidth,
    this.gradient,
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
      borderRadius: borderRadius,
      padding: padding,
      backgroundColor: backgroundColor ?? theme.primaryColor,
      textColor: textColor,
      elevation: elevation,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      textStyle: textStyle,
      minWidth: minWidth,
      gradient: gradient,
    );
  }
}
