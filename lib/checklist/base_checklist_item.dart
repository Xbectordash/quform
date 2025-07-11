import 'package:flutter/material.dart';

/// A generic class representing an item in a checklist.
///
/// This class is used to manage the state of individual items in a checklist widget.
/// It holds the item's value, display label, selection state, and optional leading/trailing widgets.
///
/// The generic type parameter [T] specifies the type of the value associated with the checklist item.
class BaseChecklistItem<T> {
  /// The value associated with this checklist item.
  ///
  /// This is the value that will be returned when this item is selected.
  /// It can be of any type [T].
  final T value;

  /// The text label to display for this checklist item.
  final String label;

  /// Whether this item is currently selected.
  ///
  /// This can be modified to change the selection state of the item.
  bool isSelected;

  /// An optional widget to display before the label.
  ///
  /// Typically an [Icon] or [CircleAvatar].
  final Widget? leading;

  /// An optional widget to display after the label.
  ///
  /// Often used for additional actions or indicators.
  final Widget? trailing;

  /// Creates a new [BaseChecklistItem].
  ///
  /// The [value] and [label] parameters are required.
  ///
  /// The [isSelected] parameter defaults to false.
  /// The [leading] and [trailing] widgets are optional.
  ///
  /// Example:
  /// ```dart
  /// BaseChecklistItem<int>(
  ///   value: 1,
  ///   label: 'Option 1',
  ///   isSelected: true,
  ///   leading: Icon(Icons.check_circle),
  /// )
  /// ```
  BaseChecklistItem({
    required this.value,
    required this.label,
    this.isSelected = false,
    this.leading,
    this.trailing,
  });

  /// Creates a copy of this [BaseChecklistItem] with the given fields replaced by the non-null
  /// parameter values.
  ///
  /// Any parameter that is not provided will keep its original value.
  ///
  /// Returns a new [BaseChecklistItem] with the updated values.
  BaseChecklistItem<T> copyWith({
    T? value,
    String? label,
    bool? isSelected,
    Widget? leading,
    Widget? trailing,
  }) {
    return BaseChecklistItem<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseChecklistItem &&
        other.value == value &&
        other.label == label &&
        other.isSelected == isSelected;
  }

  @override
  /// The hash code for this object.
  ///
  /// Uses the hash codes of [value], [label], and [isSelected] to generate
  /// a combined hash code.
  int get hashCode => value.hashCode ^ label.hashCode ^ isSelected.hashCode;
}
