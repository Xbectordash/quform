import 'package:flutter/material.dart';
import 'base_button.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? elevation;
  final TextStyle? textStyle;
  final double? minWidth;

  const SecondaryButton({
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
    this.borderColor,
    this.textColor,
    this.backgroundColor = Colors.transparent,
    this.prefixIcon,
    this.suffixIcon,
    this.elevation = 0,
    this.textStyle,
    this.minWidth,
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
      backgroundColor: backgroundColor,
      textColor: textColor ?? theme.primaryColor,
      borderSide: BorderSide(
        color: borderColor ?? theme.primaryColor,
        width: 1.5,
      ),
      elevation: elevation,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      textStyle: textStyle,
      minWidth: minWidth,
    );
  }
}
