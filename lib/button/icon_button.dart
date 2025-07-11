import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? splashColor;
  final double elevation;
  final bool isCircle;
  final EdgeInsetsGeometry? padding;
  final String? tooltip;
  final bool isDisabled;
  final double? minSize;
  final BoxConstraints? constraints;
  final bool enableFeedback;

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
