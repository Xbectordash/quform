import 'package:flutter/material.dart';

/// A base button widget that provides common button functionality and styling.
///
/// This is an internal widget used as a foundation for other button types in the
/// library. It handles common button behaviors like loading states, disabled states,
/// and basic styling that's shared across different button variants.
///
/// For most use cases, you'll want to use one of the specialized button widgets
/// like [PrimaryButton], [SecondaryButton], or [CustomTextButton] instead.
class BaseButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Whether the button should expand to fill the available horizontal space.
  ///
  /// When true, the button will take the full width of its parent.
  /// Defaults to true.
  final bool isFullWidth;

  /// Whether to show a loading indicator instead of the button's content.
  ///
  /// When true, a circular progress indicator is shown in place of the button's text.
  /// Defaults to false.
  final bool isLoading;

  /// Whether the button is disabled.
  ///
  /// When true, the button will be displayed in a disabled state and won't respond to input.
  /// Defaults to false.
  final bool isDisabled;

  /// The width of the button.
  ///
  /// If null, the button will size itself to its contents unless [isFullWidth] is true.
  final double? width;

  /// The height of the button.
  ///
  /// Defaults to 48.0 logical pixels.
  final double? height;

  /// The radius of the button's corners.
  ///
  /// Defaults to 24.0, which creates a pill-shaped button.
  final double borderRadius;

  /// The padding around the button's content.
  ///
  /// If null, defaults to 24 pixels horizontal and 12 pixels vertical padding.
  final EdgeInsetsGeometry? padding;

  /// The background color of the button.
  ///
  /// If null, defaults to the theme's primary color.
  final Color? backgroundColor;

  /// The color of the button's text and icon.
  ///
  /// If null, defaults to white.
  final Color? textColor;

  /// The color of the button's background when disabled.
  ///
  /// If null, defaults to the theme's disabled color.
  final Color? disabledColor;

  /// The elevation of the button's material.
  ///
  /// Controls the size of the shadow below the button.
  /// Defaults to 0 (no shadow).
  final double? elevation;

  /// An optional widget to display before the button's text.
  final Widget? prefixIcon;

  /// An optional widget to display after the button's text.
  final Widget? suffixIcon;

  /// The style for the button's text.
  ///
  /// If non-null, it's merged with the default text style.
  final TextStyle? textStyle;

  /// The minimum width of the button.
  ///
  /// If both [minWidth] and [width] are provided, [width] takes precedence.
  final double? minWidth;

  /// The border to draw around the button.
  ///
  /// If null, no border is drawn.
  final BorderSide? borderSide;

  /// A gradient to use for the button's background.
  ///
  /// If provided, this overrides [backgroundColor].
  final Gradient? gradient;

  /// Creates a new [BaseButton].
  ///
  /// The [text] and [onPressed] parameters are required.
  ///
  /// By default, the button has a height of 48.0, a border radius of 24.0,
  /// and expands to fill the available width. The background color defaults to
  /// the theme's primary color with white text.
  ///
  /// ```dart
  /// BaseButton(
  ///   text: 'Click me',
  ///   onPressed: () {
  ///     // Handle button press
  ///   },
  ///   backgroundColor: Colors.blue,
  ///   textColor: Colors.white,
  /// )
  /// ```
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
