import 'package:flutter/material.dart';
import 'base_checklist_item.dart';

/// A customizable multi-select checklist widget that allows users to select multiple items.
///
/// This widget displays a list of checkboxes that can be toggled on and off. It supports
/// features like select all, custom styling, and scrollable lists. The selected values
/// are maintained in a list and can be accessed via the [onChanged] callback.
///
/// The generic type parameter [T] represents the type of the value that each checklist item holds.
class MultiSelectChecklist<T> extends StatefulWidget {
  /// The list of items to display in the checklist.
  final List<BaseChecklistItem<T>> items;

  /// Called when the user selects or deselects an item.
  ///
  /// The list contains the values of all currently selected items.
  final ValueChanged<List<T>> onChanged;

  /// The initial list of selected values.
  /// If provided, the corresponding items will be pre-selected when the widget is first built.
  final List<T>? initialValues;

  /// An optional widget to display above the checklist.
  final Widget? title;

  /// Whether to show dividers between checklist items.
  /// Defaults to false.
  final bool showDivider;

  /// The color to use for the active checkbox and selected item text.
  /// If null, defaults to the theme's primary color.
  final Color? activeColor;

  /// The color to use for the check icon when the checkbox is checked.
  /// If null, defaults to the theme's onPrimary color.
  final Color? checkColor;

  /// The background color of the list tile.
  /// If null, defaults to the theme's card color.
  final Color? tileColor;

  /// The background color of the list tile when selected.
  /// If null, defaults to primary color with 10% opacity.
  final Color? selectedTileColor;

  /// Where to place the control in relation to the text.
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

  /// Whether to show a "Select All" option at the top of the list.
  /// Defaults to false.
  final bool showSelectAll;

  /// The text to display for the "Select All" option.
  /// Only used when [showSelectAll] is true.
  /// Defaults to 'Select All'.
  final String selectAllText;

  /// Creates a new [MultiSelectChecklist].
  ///
  /// The [items] and [onChanged] parameters are required.
  ///
  /// By default, the checklist uses the theme's primary color for the active state
  /// and displays items in a non-scrollable column. The control is placed at the
  /// leading edge of each item.
  const MultiSelectChecklist({
    Key? key,
    required this.items,
    required this.onChanged,
    this.initialValues,
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
    this.showSelectAll = false,
    this.selectAllText = 'Select All',
  }) : super(key: key);

  @override
  State<MultiSelectChecklist<T>> createState() => _MultiSelectChecklistState<T>();
}

class _MultiSelectChecklistState<T> extends State<MultiSelectChecklist<T>> {
  late List<T> _selectedValues;
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    _selectedValues = List<T>.from(widget.initialValues ?? []);
    _updateSelectAll();
  }

  @override
  void didUpdateWidget(MultiSelectChecklist<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValues != oldWidget.initialValues) {
      setState(() {
        _selectedValues = List<T>.from(widget.initialValues ?? []);
        _updateSelectAll();
      });
    }
  }

  void _updateSelectAll() {
    if (widget.items.isEmpty) {
      _selectAll = false;
      return;
    }
    _selectAll = _selectedValues.length == widget.items.length;
  }

  Widget _buildList() {
    final theme = Theme.of(context);
    final items = widget.items.map((item) {
      final isSelected = _selectedValues.contains(item.value);
      
      return Theme(
        data: theme.copyWith(
          unselectedWidgetColor: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
        ),
        child: CheckboxListTile(
          value: isSelected,
          onChanged: (bool? selected) => _handleItemTap(item, selected ?? false),
          title: Text(
            item.label,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isSelected ? theme.primaryColor : null,
            ),
          ),
          secondary: item.leading,
          controlAffinity: widget.controlAffinity,
          activeColor: widget.activeColor ?? theme.primaryColor,
          checkColor: widget.checkColor ?? theme.colorScheme.onPrimary,
          tileColor: widget.tileColor,
          selectedTileColor: widget.selectedTileColor ?? theme.primaryColor.withOpacity(0.1),
          selected: isSelected,
          dense: widget.dense,
          contentPadding: widget.contentPadding,
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

  void _handleItemTap(BaseChecklistItem<T> item, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedValues.contains(item.value)) {
          _selectedValues.add(item.value);
        }
      } else {
        _selectedValues.remove(item.value);
      }
      _updateSelectAll();
    });
    widget.onChanged(_selectedValues);
  }

  void _toggleSelectAll(bool? selected) {
    if (selected == null) return;
    
    setState(() {
      _selectAll = selected;
      if (_selectAll) {
        _selectedValues = widget.items.map((item) => item.value).toList();
      } else {
        _selectedValues.clear();
      }
    });
    
    widget.onChanged(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _buildList();
    
    if (widget.isScrollable) {
      content = ListView.builder(
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
        itemCount: (widget.showSelectAll ? 1 : 0) + 
                  (widget.showDivider ? widget.items.length * 2 - 1 : widget.items.length),
        itemExtent: widget.itemExtent,
        itemBuilder: (context, index) {
          if (widget.showSelectAll && index == 0) {
            return Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
              ),
              child: CheckboxListTile(
                value: _selectAll,
                onChanged: _toggleSelectAll,
                title: Text(
                  widget.selectAllText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                controlAffinity: widget.controlAffinity,
                activeColor: widget.activeColor ?? Theme.of(context).primaryColor,
                checkColor: widget.checkColor ?? Theme.of(context).colorScheme.onPrimary,
                tileColor: widget.tileColor,
                dense: widget.dense,
                contentPadding: widget.contentPadding,
                shape: widget.shape,
                autofocus: widget.autofocus,
              ),
            );
          }
          
          final adjustedIndex = widget.showSelectAll ? index - 1 : index;
          
          if (widget.showDivider && adjustedIndex.isOdd) {
            return const Divider(height: 1);
          }
          
          final itemIndex = widget.showDivider ? adjustedIndex ~/ 2 : adjustedIndex;
          final item = widget.items[itemIndex];
          final isSelected = _selectedValues.contains(item.value);
          
          return Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
            child: CheckboxListTile(
              value: isSelected,
              onChanged: (bool? selected) => _handleItemTap(item, selected ?? false),
              title: Text(
                item.label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? Theme.of(context).primaryColor : null,
                ),
              ),
              secondary: item.leading,
              controlAffinity: widget.controlAffinity,
              activeColor: widget.activeColor ?? Theme.of(context).primaryColor,
              checkColor: widget.checkColor ?? Theme.of(context).colorScheme.onPrimary,
              tileColor: widget.tileColor,
              selectedTileColor: widget.selectedTileColor ?? 
                  Theme.of(context).primaryColor.withOpacity(0.1),
              selected: isSelected,
              dense: widget.dense,
              contentPadding: widget.contentPadding,
              shape: widget.shape,
              autofocus: widget.autofocus,
            ),
          );
        },
      );
    } else if (widget.showSelectAll) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
            child: CheckboxListTile(
              value: _selectAll,
              onChanged: _toggleSelectAll,
              title: Text(
                widget.selectAllText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              controlAffinity: widget.controlAffinity,
              activeColor: widget.activeColor ?? Theme.of(context).primaryColor,
              checkColor: widget.checkColor ?? Theme.of(context).colorScheme.onPrimary,
              tileColor: widget.tileColor,
              dense: widget.dense,
              contentPadding: widget.contentPadding,
              shape: widget.shape,
              autofocus: widget.autofocus,
            ),
          ),
          if (widget.showDivider) const Divider(height: 1),
          content,
        ],
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
              style: Theme.of(context).textTheme.titleMedium ?? 
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
