import 'package:flutter/material.dart';
import 'base_button.dart';

/// A secondary action button with an outlined style, typically used for less prominent actions.
///
/// This button is commonly used for secondary actions in forms, dialogs, or as an alternative
/// to the primary button. It features an outline style and can be customized with various properties
/// to match your app's design system.
class SecondaryButton extends StatelessWidget {
  /// The button's label text.
  final String text;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Whether the button should expand to fill the available horizontal space.
  /// Defaults to true.
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
  /// Defaults to 48.0 logical pixels.
  final double? height;

  /// The radius of the button's corners.
  /// Defaults to 24.0 logical pixels (fully rounded corners for default height).
  final double borderRadius;

  /// The padding around the button's child.
  /// If null, uses default padding based on the button's size.
  final EdgeInsetsGeometry? padding;

  /// The color of the button's border.
  /// If null, defaults to the theme's primary color.
  final Color? borderColor;

  /// The color of the button's text.
  /// If null, defaults to the theme's primary color.
  final Color? textColor;

  /// The background color of the button.
  /// Defaults to transparent.
  final Color? backgroundColor;

  /// An optional icon to display before the button's text.
  final Widget? prefixIcon;

  /// An optional icon to display after the button's text.
  final Widget? suffixIcon;

  /// The elevation of the button's shadow.
  /// Defaults to 0 (no elevation).
  final double? elevation;

  /// The style for the button's text.
  /// If non-null, it's merged with the default text style.
  final TextStyle? textStyle;

  /// The minimum width of the button.
  /// If both [minWidth] and [width] are provided, [width] takes precedence.
  final double? minWidth;

  /// Creates a new [SecondaryButton].
  ///
  /// The [text] and [onPressed] parameters are required.
  ///
  /// By default, the button has a height of 48.0, fully rounded corners (borderRadius: 24.0),
  /// and a transparent background with a primary color border and text.
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
    // Delegate the rendering to BaseButton with the appropriate properties
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
