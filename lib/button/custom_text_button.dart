import 'package:flutter/material.dart';
import 'base_button.dart';

/// A custom text button widget that follows Material Design guidelines with extended customization options.
///
/// This button is typically used for less prominent actions, such as those in dialogs or cards.
/// It has a transparent background and can be customized with various text styles and decorations.
///
/// Note: This is a custom implementation to avoid naming conflict with Flutter's built-in TextButton.
class CustomTextButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Whether the button should expand to fill the available horizontal space.
  /// Defaults to false.
  final bool isFullWidth;

  /// Whether to show a loading indicator instead of the button text.
  /// Defaults to false.
  final bool isLoading;

  /// Whether the button is disabled.
  /// When true, the button will be displayed in a disabled state and won't respond to input.
  /// Defaults to false.
  final bool isDisabled;

  /// The width of the button.
  /// If null, the button will size itself to its contents.
  final double? width;

  /// The height of the button.
  /// Defaults to 40.0 logical pixels.
  final double? height;

  /// The padding around the button's child.
  /// If null, defaults to 8 pixels horizontal and 4 pixels vertical padding.
  final EdgeInsetsGeometry? padding;

  /// The color of the button's text.
  /// If null, defaults to the theme's primary color.
  final Color? textColor;

  /// An optional icon to display before the button's text.
  final Widget? prefixIcon;

  /// An optional icon to display after the button's text.
  final Widget? suffixIcon;

  /// The style for the button's text.
  /// If non-null, it's merged with the default text style.
  final TextStyle? textStyle;

  /// The minimum width of the button.
  /// If both [minWidth] and [width] are provided, [width] takes precedence.
  final double? minWidth;

  /// The size of the font to use for the button's text.
  /// If null, the default size from the text style or theme is used.
  final double? fontSize;

  /// The weight of the font to use for the button's text.
  /// Defaults to FontWeight.w500 (medium weight).
  final FontWeight? fontWeight;

  /// The decoration to paint near the text (e.g., an underline).
  final TextDecoration? decoration;

  /// The color in which to paint the text decoration.
  final Color? decorationColor;

  /// Creates a new [CustomTextButton].
  ///
  /// The [text] and [onPressed] parameters are required.
  ///
  /// By default, the button has a height of 40.0, medium font weight (500),
  /// and a transparent background. The text color defaults to the theme's primary color.
  const CustomTextButton({
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
    // Delegate the rendering to BaseButton with text button specific properties
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
