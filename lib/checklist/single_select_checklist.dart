import 'package:flutter/material.dart';
import 'base_checklist_item.dart';

class SingleSelectChecklist<T> extends StatefulWidget {
  final List<BaseChecklistItem<T>> items;
  final ValueChanged<T?> onChanged;
  final T? initialValue;
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
