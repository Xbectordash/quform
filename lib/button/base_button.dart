import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
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
  final Color? disabledColor;
  final double? elevation;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final double? minWidth;
  final BorderSide? borderSide;
  final Gradient? gradient;

  const BaseButton({
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
    this.textColor,
    this.disabledColor,
    this.elevation,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.minWidth,
    this.borderSide,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? theme.primaryColor,
      foregroundColor: textColor ?? Colors.white,
      disabledBackgroundColor: disabledColor ?? theme.disabledColor,
      elevation: elevation ?? 0,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: borderSide ?? BorderSide.none,
      ),
      minimumSize: Size(
        isFullWidth ? double.infinity : (minWidth ?? 0),
        height!,
      ),
    );

    Widget child = isLoading
        ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                textColor ?? Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: 8)],
              Text(
                text,
                style: textStyle ??
                    theme.textTheme.labelLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (suffixIcon != null) ...[const SizedBox(width: 8), suffixIcon!],
            ],
          );

    return Container(
      width: isFullWidth ? double.infinity : width,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: buttonStyle,
        child: child,
      ),
    );
  }
}
