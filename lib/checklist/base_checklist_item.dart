import 'package:flutter/material.dart';

class BaseChecklistItem<T> {
  final T value;
  final String label;
  bool isSelected;
  final Widget? leading;
  final Widget? trailing;

  BaseChecklistItem({
    required this.value,
    required this.label,
    this.isSelected = false,
    this.leading,
    this.trailing,
  });

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
  int get hashCode => value.hashCode ^ label.hashCode ^ isSelected.hashCode;
}
