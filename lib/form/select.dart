import 'package:flutter/material.dart';
import 'package:moonspace/form/form.dart';

import 'package:moonspace/widgets/functions.dart';

class OptionDialog<T> extends StatelessWidget {
  const OptionDialog({
    super.key,
    required this.options,
    this.multi = false,
    required this.child,
    this.semanticLabel,
    required this.title,
    required this.actions,
  });

  final Widget child;
  final List<Option<T>> options;
  final bool multi;
  final String? semanticLabel;
  final Widget title;
  final Widget Function(BuildContext context, Set<T> selectedRadio) actions;

  @override
  Widget build(BuildContext context) {
    Set<T> selected = {};

    return Semantics(
      label: semanticLabel,
      button: true,
      enabled: true,
      child: InkWell(
        child: child,
        onTap: () {
          context.showFormDialog(
            builder: (context) => Box(
              title: title,
              height: 400,
              children: (context) => [
                OptionBox(
                  options: options,
                  onChange: (selected) {
                    selected = selected;
                  },
                  multi: multi,
                ),
              ],
              actions: (context) {
                return actions(context, selected);
              },
            ),
          );
        },
      ),
    );
  }
}

class Option<T> {
  final Widget? title;
  final Widget? subtitle;
  final Widget? secondary;
  final T value;
  final Object? compareBy;
  final bool selected;

  const Option({
    this.title,
    this.subtitle,
    this.secondary,
    required this.value,
    this.compareBy,
    this.selected = false,
  });
}

enum OptionDisplay { list, chip, switchTile }

class OptionBox<T> extends StatefulWidget {
  const OptionBox({
    super.key,
    required this.options,
    this.multi = false,
    this.divider = false,
    this.semanticLabel,
    this.onChange,
    this.init,
    this.display = OptionDisplay.list,
  });

  final List<Option<T>> options;
  final bool multi;
  final bool divider;
  final String? semanticLabel;
  final void Function(Set<T> selected)? onChange;
  final void Function(Set<T> selected)? init;
  final OptionDisplay display;

  @override
  State<OptionBox<T>> createState() => _OptionBoxState<T>();
}

class _OptionBoxState<T> extends State<OptionBox<T>> {
  late Set<Object> selectedKeys;

  @override
  void initState() {
    super.initState();

    final keys = widget.options.map(_getComparableValue).toList();
    final duplicates = keys.toSet()
      ..removeWhere((v) => keys.where((x) => x == v).length == 1);

    if (duplicates.isNotEmpty) {
      throw FlutterError(
        'OptionBox requires all Option.compareBy (or value) to be unique. '
        'Found duplicates: $duplicates',
      );
    }

    selectedKeys = widget.options
        .where((option) => option.selected)
        .map(_getComparableValue)
        .toSet();

    widget.init?.call(_getSelectedValues());
  }

  Object _getComparableValue(Option<T> option) {
    final val = option.compareBy ?? option.value;
    if (val == null) {
      throw FlutterError('Option.value and compareBy cannot both be null.');
    }
    return val;
  }

  bool _isSelected(Option<T> option) {
    final compareValue = _getComparableValue(option);
    return selectedKeys.contains(compareValue);
  }

  Set<T> _getSelectedValues() {
    return widget.options
        .where((opt) => _isSelected(opt))
        .map((opt) => opt.value)
        .toSet();
  }

  void _onSelect(Option<T> option, bool selected) {
    final key = _getComparableValue(option);
    setState(() {
      if (widget.multi) {
        selected ? selectedKeys.add(key) : selectedKeys.remove(key);
      } else {
        selectedKeys = {key};
      }
    });
    widget.onChange?.call(_getSelectedValues());
  }

  @override
  Widget build(BuildContext context) {
    final optionList = widget.options.toList();

    if (widget.display == OptionDisplay.chip) {
      return Wrap(
        spacing: 8,
        children: List.generate(optionList.length, (index) {
          final option = optionList[index];
          final isSelected = _isSelected(option);

          return FilterChip(
            label: option.secondary == null
                ? option.title ?? Text(option.value.toString())
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      option.secondary!,
                      SizedBox(width: 4),
                      option.title ?? Text(option.value.toString()),
                    ],
                  ),
            selected: isSelected,
            onSelected: (value) => _onSelect(option, value),
          );
        }),
      );
    }

    // Default: List mode
    return ListView.separated(
      shrinkWrap: true,
      itemCount: optionList.length,
      separatorBuilder: (context, index) =>
          widget.divider ? const Divider(height: 1) : const SizedBox(),
      itemBuilder: (context, index) {
        final option = optionList[index];
        final isSelected = _isSelected(option);
        final groupValue = selectedKeys.length == 1
            ? widget.options.firstWhere((opt) => _isSelected(opt)).value
            : null;

        if (widget.display == OptionDisplay.switchTile) {
          return SwitchListTile(
            title: option.title ?? Text(option.value.toString()),
            subtitle: option.subtitle,
            secondary: option.secondary,
            value: isSelected,
            selected: isSelected,
            onChanged: (value) => _onSelect(option, value),
          );
        }

        return widget.multi
            ? CheckboxListTile(
                title: option.title ?? Text(option.value.toString()),
                subtitle: option.subtitle,
                secondary: option.secondary,
                value: isSelected,
                selected: isSelected,
                onChanged: (value) => _onSelect(option, value ?? false),
              )
            : RadioListTile<T>(
                title: option.title ?? Text(option.value.toString()),
                subtitle: option.subtitle,
                controlAffinity: ListTileControlAffinity.trailing,
                value: option.value,
                selected: isSelected,
                secondary: option.secondary,
                groupValue: groupValue,
                onChanged: (value) {
                  if (value != null) _onSelect(option, true);
                },
              );
      },
    );
  }
}
