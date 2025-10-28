import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moonspace/helper/stream/debounce.dart';
import 'package:moonspace/widgets/async_lock.dart';

typedef AsyncTextType = ({String? error, bool load});
typedef ValueParser<T> = T? Function(String value);
typedef ValueFormatter<T> = String Function(T value);

class AsyncTextFormField<T> extends StatefulWidget {
  const AsyncTextFormField({
    super.key,
    this.controller,
    this.asyncValidator,
    this.validator,
    required this.valueParser,
    required this.valueFormatter,
    this.style,
    this.initialValue,
    this.decoration,
    this.autofocus = false,
    this.enabled = true,
    this.showPrefix = false,
    this.showSubmitSuffix = false,
    this.showClear = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.suffix = const [],
    this.milliseconds = 300,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.password = false,
    this.autofillHints,
    this.keyboardType,
    this.inputFormatters = const [],
    this.textInputAction,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.clearFunc,
    this.onEditingComplete,
    this.buildCounter,
    this.scrollPhysics,
  });

  final TextEditingController? controller;
  final Future<void> Function(T value)? asyncValidator;
  final String? Function(T value)? validator;
  final ValueParser<T> valueParser;
  final ValueFormatter<T> valueFormatter;
  final InputDecoration Function(
    AsyncTextType asyncText,
    TextEditingController textCon,
  )?
  decoration;
  final T? initialValue;
  final bool autofocus;
  final bool showPrefix;
  final bool enabled;
  final bool showSubmitSuffix;
  final bool showClear;
  final bool autocorrect;
  final bool enableSuggestions;
  final List<Widget> suffix;
  final int milliseconds;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool password;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final List<TextInputFormatter> inputFormatters;

  final TextInputAction? textInputAction;
  final void Function(T? value)? onChanged;
  final Future<void> Function(TextEditingController controller)? onSubmit;
  final Future<void> Function(
    TextEditingController controller,
    Function(String value) onChanged,
  )?
  onTap;
  final Future<void> Function(TextEditingController controller)?
  onEditingComplete;
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })?
  buildCounter;
  final void Function()? clearFunc;
  final ScrollPhysics? scrollPhysics;

  @override
  State<AsyncTextFormField<T>> createState() => _AsyncTextFormFieldState<T>();
}

class _AsyncTextFormFieldState<T> extends State<AsyncTextFormField<T>> {
  AsyncTextType asynctype = (error: null, load: false);
  final focusNode = FocusNode(debugLabel: 'AsyncTextFormField');
  final key = GlobalKey<FormFieldState>();

  late TextEditingController textCon;

  late final StreamController<String?> validateStream;

  @override
  void initState() {
    textCon = (widget.controller ?? TextEditingController())
      ..text = widget.initialValue != null
          ? widget.valueFormatter(widget.initialValue as T)
          : '';

    validateStream = createDebounceFunc(widget.milliseconds, (
      String? value,
    ) async {
      asynctype = (error: 'Checking...', load: true);
      setState(() {});
      key.currentState?.validate();

      // Parse the string value to type T
      final T? parsedValue = value == null ? null : widget.valueParser(value);
      if (parsedValue == null) {
        asynctype = (error: 'Invalid format', load: false);
      } else {
        // First run sync validator
        final String? validationError = widget.validator?.call(parsedValue);
        if (validationError != null) {
          asynctype = (error: validationError, load: false);
        } else {
          // If sync validation passes, run async validation
          asynctype = (error: null, load: true);
          try {
            await widget.asyncValidator?.call(parsedValue);
            asynctype = (error: null, load: false);
          } catch (e) {
            asynctype = (error: e.toString(), load: false);
          }
        }
      }

      setState(() {});
      key.currentState?.validate();
    });

    focusNode.addListener(_onFocusChange);

    super.initState();
  }

  @override
  void dispose() {
    validateStream.close();
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void onChanged(String? value) {
    final T? parsedValue = value == null ? null : widget.valueParser(value);
    widget.onChanged?.call(parsedValue);
    validateStream.add(value);
  }

  void onFieldSubmitted(String value) async {
    final T? parsedValue = widget.valueParser(value);
    if (parsedValue == null) {
      asynctype = (error: 'Invalid format', load: false);
      setState(() {});
      return;
    }

    try {
      await widget.asyncValidator?.call(parsedValue);
      // If we reach here, validation succeeded
      if (widget.initialValue != parsedValue) {
        widget.onSubmit?.call(textCon);
      }
    } catch (e) {
      asynctype = (error: e.toString(), load: false);
      setState(() {});
    }
  }

  void _onFocusChange() {
    if (focusNode.hasFocus) {
      widget.onTap?.call(textCon, onChanged);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textCon,
      key: key,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,

      inputFormatters: widget.inputFormatters,

      autofocus: widget.autofocus,

      //
      autocorrect:
          widget.inputFormatters.isEmpty &&
          !widget.password &&
          widget.autocorrect,
      enableSuggestions: !widget.password && widget.enableSuggestions,

      //
      onTapOutside: (event) => focusNode.unfocus(),
      onEditingComplete: () => widget.onEditingComplete?.call(textCon),
      onFieldSubmitted: onFieldSubmitted,
      // onSaved: (v) => owl(v),
      onTap: () => widget.onTap?.call(textCon, onChanged),

      //
      focusNode: focusNode,

      obscureText: widget.password,
      minLines: widget.minLines,
      maxLines: widget.password ? 1 : widget.maxLines,
      maxLength: widget.maxLength,

      enabled: widget.enabled,
      scrollPhysics: widget.scrollPhysics,

      //
      buildCounter: widget.buildCounter,

      //
      style: widget.style,

      decoration:
          ((widget.decoration)?.call(asynctype, textCon) ??
                  const InputDecoration())
              .copyWith(
                isDense: true,
                prefixIcon: !widget.showPrefix
                    ? null
                    : Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.all(16),
                        child: (asynctype.error == null)
                            ? const Icon(Icons.done)
                            : (asynctype.load == true
                                  ? const CircularProgressIndicator()
                                  : const Icon(Icons.error_outline)),
                      ),
                suffixIcon:
                    (!widget.enabled ||
                        (widget.suffix.isEmpty &&
                            !widget.showSubmitSuffix &&
                            !widget.showClear))
                    ? null
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...widget.suffix,
                          if (widget.showClear && textCon.text.isNotEmpty)
                            IconButton.filledTonal(
                              icon: const Icon(Icons.clear),
                              onPressed: () async {
                                textCon.clear();
                                widget.clearFunc?.call();
                              },
                            ),
                          if (widget.showSubmitSuffix)
                            asynctype.load
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : (widget.initialValue ==
                                      widget.valueParser(textCon.text))
                                ? const Icon(Icons.edit)
                                : (asynctype.error != null)
                                ? const Icon(Icons.error)
                                : (widget.onSubmit == null)
                                ? const SizedBox()
                                : AsyncLock(
                                    builder:
                                        (
                                          isLoading,
                                          status,
                                          lock,
                                          open,
                                          setStatus,
                                        ) {
                                          return IconButton.filledTonal(
                                            icon: const Icon(Icons.done),
                                            onPressed: () async {
                                              lock();
                                              await widget.onSubmit?.call(
                                                textCon,
                                              );
                                              open();
                                            },
                                          );
                                        },
                                  ),
                        ],
                      ),
              ),
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (asynctype.load) {
          return 'Checking';
        }

        // Run sync validator first
        final T? parsedValue = value == null ? null : widget.valueParser(value);
        if (parsedValue == null) {
          return null;
        }

        // Run the widget's sync validator if provided
        final String? syncError = widget.validator?.call(parsedValue);
        if (syncError != null) {
          return syncError;
        }

        // Return any async validation errors
        return asynctype.error;
      },
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      autofillHints: widget.autofillHints,
      keyboardType: widget.keyboardType,
    );
  }
}

class AsyncText {
  static final positiveInt = const TextInputType.numberWithOptions(
    signed: false,
    decimal: false,
  );
  static final negativeInt = const TextInputType.numberWithOptions(
    signed: true,
    decimal: false,
  );
  static final positiveDouble = const TextInputType.numberWithOptions(
    signed: false,
    decimal: true,
  );
  static final negativeDouble = const TextInputType.numberWithOptions(
    signed: true,
    decimal: true,
  );

  static final positiveIntFormatter = [FilteringTextInputFormatter.digitsOnly];
  static final negativeIntFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
  ];
  static final positiveDoubleIntFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
  ];
  static final negativeDoubleFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
  ];

  static Future<void> datetimeSelect(
    BuildContext context,
    TextEditingController controller,
    Function(String value) onChanged,
    DateFormat format,
    DateTime firstDate,
    DateTime lastDate,
  ) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final date = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date != null) {
      final formattedDate = format.format(date);
      controller.text = formattedDate;
      onChanged(formattedDate);
    }
  }
}

class UpperCaseTextFormatter implements TextInputFormatter {
  const UpperCaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
