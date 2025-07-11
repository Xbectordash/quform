import 'package:flutter/material.dart';
import 'base_checklist_item.dart';

/// A customizable single-select checklist widget that allows users to select one item from a list.
///
/// This widget displays a list of radio buttons that allow single selection.
/// It supports various customization options for appearance and behavior.
///
/// The generic type parameter [T] represents the type of the value that each checklist item holds.
class SingleSelectChecklist<T> extends StatefulWidget {
  /// The list of items to display in the checklist.
  final List<BaseChecklistItem<T>> items;

  /// Called when the user selects an item.
  ///
  /// The callback receives the value of the selected item, or null if the selection is cleared.
  final ValueChanged<T?> onChanged;

  /// The initially selected value.
  /// If provided, the corresponding item will be pre-selected when the widget is first built.
  final T? initialValue;

  /// An optional widget to display above the checklist.
  final Widget? title;

  /// Whether to show dividers between checklist items.
  /// Defaults to false.
  final bool showDivider;

  /// The color to use for the active radio button and selected item text.
  /// If null, defaults to the theme's primary color.
  final Color? activeColor;

  /// The color to use for the radio button's check mark when selected.
  /// If null, defaults to the theme's onPrimary color.
  final Color? checkColor;

  /// The background color of the list tile.
  /// If null, defaults to the theme's card color.
  final Color? tileColor;

  /// The background color of the list tile when selected.
  /// If null, defaults to primary color with 10% opacity.
  final Color? selectedTileColor;

  /// Where to place the radio button in relation to the text.
  /// Defaults to [ListTileControlAffinity.leading].
  final ListTileControlAffinity controlAffinity;

  /// Whether the list tile is part of a vertically dense list.
  /// If true, reduces the vertical padding of the list tile.
  /// Defaults to false.
  final bool dense;

  /// The padding around the list tile's contents.
  /// If null, uses default padding based on the [dense] property.
  final EdgeInsetsGeometry? contentPadding;

  /// Whether this list tile should be focused initially.
  /// Defaults to false.
  final bool autofocus;

  /// The shape of the list tile's [InkWell].
  /// If null, defaults to a rectangle border with 4.0 radius.
  final ShapeBorder? shape;

  /// Whether the list should be scrollable.
  /// If true, wraps the list in a [ListView].
  /// Defaults to false.
  final bool isScrollable;

  /// How the scroll view should respond to user input.
  /// Only used when [isScrollable] is true.
  final ScrollPhysics? physics;

  /// The height of each item in the list.
  /// Only used when [isScrollable] is true.
  final double? itemExtent;

  /// Whether the extent of the scroll view in the scroll direction should be
  /// determined by the contents being viewed.
  /// Only used when [isScrollable] is true.
  final bool shrinkWrap;

  /// Creates a new [SingleSelectChecklist].
  ///
  /// The [items] and [onChanged] parameters are required.
  ///
  /// By default, the checklist uses the theme's primary color for the active state
  /// and displays items in a non-scrollable column. The radio button is placed at the
  /// leading edge of each item by default.
  const SingleSelectChecklist({
    Key? key,
    required this.items,
    required this.onChanged,
    this.initialValue,
    this.title,
    this.showDivider = false,
    this.activeColor,
    this.checkColor,
    this.tileColor,
    this.selectedTileColor,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.dense = false,
    this.contentPadding,
    this.autofocus = false,
    this.shape,
    this.isScrollable = false,
    this.physics,
    this.itemExtent,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  State<SingleSelectChecklist<T>> createState() => _SingleSelectChecklistState<T>();
}

class _SingleSelectChecklistState<T> extends State<SingleSelectChecklist<T>> {
  late T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(SingleSelectChecklist<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _selectedValue = widget.initialValue;
      });
    }
  }

  Widget _buildList() {
    final theme = Theme.of(context);
    final items = widget.items.map((item) {
      final isSelected = item.value == _selectedValue;
      
      return Theme(
        data: theme.copyWith(
          unselectedWidgetColor: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
        ),
        child: ListTile(
          contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: widget.controlAffinity == ListTileControlAffinity.leading
              ? _buildRadio(item)
              : null,
          title: Text(
            item.label,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isSelected ? theme.primaryColor : null,
            ),
          ),
          trailing: widget.controlAffinity == ListTileControlAffinity.trailing
              ? _buildRadio(item)
              : item.trailing,
          onTap: () => _handleItemTap(item),
          tileColor: widget.tileColor,
          selectedTileColor: widget.selectedTileColor ?? theme.primaryColor.withOpacity(0.1),
          selected: isSelected,
          dense: widget.dense,
          shape: widget.shape,
          autofocus: widget.autofocus,
        ),
      );
    }).toList();

    if (widget.showDivider) {
      final dividedItems = <Widget>[];
      for (var i = 0; i < items.length; i++) {
        dividedItems.add(items[i]);
        if (i < items.length - 1) {
          dividedItems.add(const Divider(height: 1));
        }
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: dividedItems,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }

  Widget _buildRadio(BaseChecklistItem<T> item) {
    return Radio<T>(
      value: item.value,
      groupValue: _selectedValue,
      onChanged: (value) => _handleItemTap(item),
      activeColor: widget.activeColor ?? Theme.of(context).primaryColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  void _handleItemTap(BaseChecklistItem<T> item) {
    setState(() {
      _selectedValue = item.value == _selectedValue ? null : item.value;
    });
    widget.onChanged(_selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _buildList();
    
    if (widget.isScrollable) {
      content = ListView.builder(
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
        itemCount: widget.showDivider ? widget.items.length * 2 - 1 : widget.items.length,
        itemExtent: widget.itemExtent,
        itemBuilder: (context, index) {
          if (widget.showDivider && index.isOdd) {
            return const Divider(height: 1);
          }
          final itemIndex = widget.showDivider ? index ~/ 2 : index;
          final item = widget.items[itemIndex];
          final isSelected = item.value == _selectedValue;
          
          return Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
            child: ListTile(
              contentPadding: widget.contentPadding ?? 
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: widget.controlAffinity == ListTileControlAffinity.leading
                  ? _buildRadio(item)
                  : null,
              title: Text(
                item.label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? Theme.of(context).primaryColor : null,
                ),
              ),
              trailing: widget.controlAffinity == ListTileControlAffinity.trailing
                  ? _buildRadio(item)
                  : item.trailing,
              onTap: () => _handleItemTap(item),
              tileColor: widget.tileColor,
              selectedTileColor: widget.selectedTileColor ?? 
                  Theme.of(context).primaryColor.withOpacity(0.1),
              selected: isSelected,
              dense: widget.dense,
              shape: widget.shape,
              autofocus: widget.autofocus,
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.titleMedium ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              child: widget.title!,
            ),
          ),
          const Divider(height: 1),
        ],
        content,
      ],
    );
  }
}
