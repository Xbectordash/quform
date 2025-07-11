import 'package:flutter/material.dart';

/// A customizable icon button widget that supports both circular and square shapes.
///
/// This widget provides an icon button with various customization options
/// including size, colors, elevation, and tooltip support. It's built on top of
/// Flutter's Material Design components for consistent behavior and appearance.
class IconBtn extends StatelessWidget {
  /// The icon to display inside the button.
  final IconData icon;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// The size of the button (width and height).
  final double size;

  /// The size of the icon within the button.
  final double iconSize;

  /// The background color of the button.
  /// If null, the button will be transparent.
  final Color? backgroundColor;

  /// The color of the icon.
  /// If null, it will use the default icon color from the theme.
  final Color? iconColor;

  /// The color of the splash effect when the button is pressed.
  final Color? splashColor;

  /// The elevation of the button's shadow.
  /// Defaults to 0 (no elevation).
  final double elevation;

  /// Whether the button should be circular (true) or square (false).
  /// Defaults to true.
  final bool isCircle;

  /// The padding around the icon.
  /// If null, defaults to 8.0 padding on all sides.
  final EdgeInsetsGeometry? padding;

  /// Optional text that describes the action that will occur when the button is pressed.
  /// This text will be shown in a tooltip when the user long-presses the button.
  final String? tooltip;

  /// Whether the button is disabled.
  /// When true, the button will be displayed in a disabled state and won't respond to input.
  final bool isDisabled;

  /// The minimum size of the button.
  /// If both [minSize] and [constraints] are provided, [constraints] will take precedence.
  final double? minSize;

  /// Defines the button's size constraints.
  /// If provided, overrides the [minSize] property.
  final BoxConstraints? constraints;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  /// Defaults to true.
  final bool enableFeedback;

  /// Creates a new [IconBtn].
  ///
  /// The [icon] and [onPressed] parameters are required.
  ///
  /// The [size] defaults to 40.0 and [iconSize] defaults to 24.0.
  /// The button is circular by default ([isCircle] is true).
  const IconBtn({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 40.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.iconColor,
    this.splashColor,
    this.elevation = 0,
    this.isCircle = true,
    this.padding,
    this.tooltip,
    this.isDisabled = false,
    this.minSize,
    this.constraints,
    this.enableFeedback = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create the base button with all the provided properties
    // The button will be wrapped in a Tooltip if tooltip text is provided
    final theme = Theme.of(context);
    final button = Material(
      color: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      shape: isCircle ? const CircleBorder() : null,
      clipBehavior: Clip.antiAlias,
      child: IconButton(
        icon: Icon(
          icon,
          size: iconSize,
          color: isDisabled ? theme.disabledColor : iconColor,
        ),
        onPressed: isDisabled ? null : onPressed,
        splashRadius: size / 2,
        padding: padding ?? const EdgeInsets.all(8.0),
        constraints: constraints ??
            (minSize != null
                ? BoxConstraints(
                    minWidth: minSize!,
                    minHeight: minSize!,
                  )
                : null),
        enableFeedback: enableFeedback,
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
