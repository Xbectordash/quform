import 'package:flutter/material.dart';
import 'base_checklist_item.dart';

class MultiSelectChecklist<T> extends StatefulWidget {
  final List<BaseChecklistItem<T>> items;
  final ValueChanged<List<T>> onChanged;
  final List<T>? initialValues;
  final Widget? title;
  final bool showDivider;
  final Color? activeColor;
  final Color? checkColor;
  final Color? tileColor;
  final Color? selectedTileColor;
  final ListTileControlAffinity controlAffinity;
  final bool dense;
  final EdgeInsetsGeometry? contentPadding;
  final bool autofocus;
  final ShapeBorder? shape;
  final bool isScrollable;
  final ScrollPhysics? physics;
  final double? itemExtent;
  final bool shrinkWrap;
  final bool showSelectAll;
  final String selectAllText;

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
