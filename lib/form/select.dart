import 'package:flutter/material.dart';
import 'package:moonspace/form/form.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';

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
  final Widget? icon;
  final T value;
  final Object? compareBy;
  final bool selected;
  final bool disabled;

  const Option({
    this.title,
    this.subtitle,
    this.icon,
    required this.value,
    this.compareBy,
    this.selected = false,
    this.disabled = false,
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
    this.controlAffinity = ListTileControlAffinity.trailing,
  });

  final List<Option<T>> options;
  final bool multi;
  final bool divider;
  final String? semanticLabel;
  final void Function(Set<T> selected)? onChange;
  final void Function(Set<T> selected)? init;
  final OptionDisplay display;
  final ListTileControlAffinity controlAffinity;

  @override
  State<OptionBox<T>> createState() => _OptionBoxState<T>();
}

class _OptionBoxState<T> extends State<OptionBox<T>> {
  Set<Object> selectedKeys = {};
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    final keys = widget.options.map(_getComparableValue).whereType<Object>().toList();

    if (_errorMessage != null) return;

    final duplicates = keys.toSet()..removeWhere((v) => keys.where((x) => x == v).length == 1);

    if (duplicates.isNotEmpty) {
      _errorMessage =
          'OptionBox requires all Option.compareBy (or value) to be unique. '
          'Found duplicates: $duplicates';
      return;
    }

    selectedKeys = widget.options
        .where((option) => option.selected)
        .map(_getComparableValue)
        .whereType<Object>()
        .toSet();

    if (!widget.multi && selectedKeys.length > 1) {
      _errorMessage =
          'OptionBox with multi=false cannot have multiple options selected. '
          'Found ${selectedKeys.length} selected options.';
      return;
    }

    widget.init?.call(_getSelectedValues());
  }

  Object? _getComparableValue(Option<T> option) {
    final val = option.compareBy ?? option.value;
    if (val == null) {
      _errorMessage = 'Option.value and compareBy cannot both be null.';
      return null;
    }
    return val;
  }

  bool _isSelected(Option<T> option) {
    final compareValue = _getComparableValue(option);
    if (compareValue == null) return false;
    return selectedKeys.contains(compareValue);
  }

  Set<T> _getSelectedValues() {
    return widget.options.where((opt) => _isSelected(opt)).map((opt) => opt.value).toSet();
  }

  void _onSelect(Option<T> option, bool selected) {
    if (option.disabled || _errorMessage != null) return;
    final key = _getComparableValue(option);
    if (key == null) return;
    setState(() {
      if (widget.multi) {
        selected ? selectedKeys.add(key) : selectedKeys.remove(key);
      } else {
        // For single-select mode, allow toggling off when using switchTile
        // For other displays (radio, checkbox), selection always sets the value
        selectedKeys = selected ? {key} : {};
      }
    });
    widget.onChange?.call(_getSelectedValues());
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(_errorMessage!, style: context.bm?.copyWith(color: context.cs.error)),
      );
    }

    final optionList = widget.options.toList();

    if (widget.display == OptionDisplay.chip) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(optionList.length, (index) {
          final option = optionList[index];
          final isSelected = _isSelected(option);

          return FilterChip(
            label: option.icon == null
                ? option.title ?? Text(option.value.toString())
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      option.icon!,
                      SizedBox(width: 8),
                      option.title ?? Text(option.value.toString()),
                    ],
                  ),
            selected: isSelected,
            onSelected: option.disabled ? null : (value) => _onSelect(option, value),
          );
        }),
      );
    }

    // Default: List mode
    if (widget.multi || widget.display == OptionDisplay.switchTile) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: optionList.length,
        separatorBuilder: (context, index) =>
            widget.divider ? const Divider(height: 1) : const SizedBox(),
        itemBuilder: (context, index) {
          final option = optionList[index];
          final isSelected = _isSelected(option);

          if (widget.display == OptionDisplay.switchTile) {
            return SwitchListTile(
              title: option.title ?? Text(option.value.toString()),
              subtitle: option.subtitle,
              secondary: option.icon,
              thumbIcon: WidgetStateProperty.all(Icon(Icons.check)),
              value: isSelected,
              selected: isSelected,
              controlAffinity: widget.controlAffinity,
              onChanged: option.disabled ? null : (value) => _onSelect(option, value),
            );
          }

          return CheckboxListTile(
            title: option.title ?? Text(option.value.toString()),
            subtitle: option.subtitle,
            secondary: option.icon,
            value: isSelected,
            selected: isSelected,
            controlAffinity: widget.controlAffinity,
            onChanged: option.disabled ? null : (value) => _onSelect(option, value ?? false),
          );
        },
      );
    }

    // Single selection: use RadioGroup
    final groupValue = selectedKeys.length == 1
        ? widget.options.firstWhere((opt) => _isSelected(opt)).value
        : null;

    return RadioGroup<T>(
      groupValue: groupValue,
      onChanged: (value) {
        if (value != null) {
          final option = widget.options.firstWhere((opt) => opt.value == value);
          if (!option.disabled) {
            _onSelect(option, true);
          }
        }
      },
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: optionList.length,
        separatorBuilder: (context, index) =>
            widget.divider ? const Divider(height: 1) : const SizedBox(),
        itemBuilder: (context, index) {
          final option = optionList[index];
          final isSelected = _isSelected(option);

          return RadioListTile<T>(
            title: option.title ?? Text(option.value.toString()),
            subtitle: option.subtitle,
            secondary: option.icon,
            value: option.value,
            selected: isSelected,
            controlAffinity: widget.controlAffinity,
            enabled: !option.disabled,
          );
        },
      ),
    );
  }
}
