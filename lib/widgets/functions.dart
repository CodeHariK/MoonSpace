import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moonspace/form/form.dart';

import 'package:moonspace/helper/extensions/theme_ext.dart';

extension FunctionContext on BuildContext {
  void showSnackBar({
    required String content,
    String? title,
    Widget? icon,
    List<Widget>? actions,
    bool close = true,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        // margin: (deco?.mar ?? e8).copyWith(bottom: 6),
        // behavior: SnackBarBehavior.floating,
        // animation: ,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 4),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            if (icon != null) icon,
            if (icon != null) const SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) Text(title),
                const SizedBox(height: 6),
                Text(content),
              ],
            ),
            const SizedBox(width: 10),
            ...?actions,
            const SizedBox(width: 10),
          ],
        ),
        showCloseIcon: close,
      ),
    );
  }

  void showMaterialBanner({
    required String title,
    Widget? icon,
    required String content,
    List<Widget>? actions,
  }) {
    ScaffoldMessenger.of(this).showMaterialBanner(
      MaterialBanner(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    ScaffoldMessenger.of(this).removeCurrentMaterialBanner();
                  },
                ),
              ],
            ),
            Text(content),
          ],
        ),
        leading: icon,
        actions: actions ?? [],
      ),
    );
  }

  Future<T?> showActionSheet<T>({
    String? title,
    String? message,
    required List<ButtonData> actions,
  }) async {
    return await showCupertinoModalPopup<T>(
      context: this,
      builder: (context) {
        return CupertinoActionSheet(
          title: title != null ? Text(title) : null,
          message: message != null ? Text(message) : null,
          actions: actions.map((e) => e.cupertinoSheetAction(context)).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              context.nav.pop();
            },
            isDefaultAction: true,
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }

  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext context) builder,
    void Function(bool, T?)? onPopInvokedWithResult,
    GlobalKey<FormState>? formKey,
    VoidCallback? onChanged,
    Color? background,
    bool showDragHandle = true,
    double horizontalPadding = 12,
    ShapeBorder? border,
  }) async {
    return await showModalBottomSheet<T>(
      context: this,
      // showDragHandle: showDragHandle,
      useSafeArea: true,
      shape: border, //1.bs.c(Colors.green).round.r(12),
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(maxWidth: mq.w - horizontalPadding),
      backgroundColor: background,

      //
      // useRootNavigator: true,
      // isScrollControlled: true,
      builder: (context) {
        return PopScope(
          onPopInvokedWithResult: onPopInvokedWithResult,
          child: Form(
            key: formKey,
            onChanged: onChanged,
            child: builder(context),
          ),
        );
      },
    );
  }

  Future<T?> showFormDialog<T>({
    required Widget Function(BuildContext context) builder,
    void Function(bool, T?)? onPopInvokedWithResult,
    GlobalKey<FormState>? formKey,
    VoidCallback? onChanged,
    Color? background,
    ShapeBorder? border,
    EdgeInsets? insetPadding,
  }) {
    return showDialog<T>(
      context: this,
      builder: (BuildContext context) {
        return PopScope(
          onPopInvokedWithResult: onPopInvokedWithResult,
          child: Dialog(
            insetPadding:
                insetPadding ??
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
            backgroundColor: background,
            clipBehavior: Clip.hardEdge,
            shape: border,
            child: Form(
              key: formKey,
              onChanged: onChanged,
              child: builder(context),
            ),
          ),
        );
      },
    );
  }

  Future<T?> showAlertDialog<T>({
    required BuildContext context,
    required String title,
    String? content,
    IconData? icon,
    required List<ButtonData> Function(BuildContext context) actions,
  }) {
    if (Device.isWeb || !Device.isIos) {
      return showDialog<T>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: content != null ? Text(content) : null,
            icon: icon != null ? Icon(icon) : null,
            actions: actions(context).toButtonBar(context),
            semanticLabel: title,
          );
        },
      );
    } else {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: content != null ? Text(content) : null,
            actions: actions(
              context,
            ).map((e) => e.cupertinoDialogAction(context)).toList(),
          );
        },
      );
    }
  }

  Future<bool> showYesNo({required String title, String? content}) async {
    return (await showAlertDialog<bool>(
          context: this,
          title: title,
          content: content,
          actions: (context) {
            return [
              ButtonData(
                text: 'cancel',
                fn: (context) => Navigator.pop(context, false),
              ),
              ButtonData(
                text: 'yes',
                fn: (context) => Navigator.pop(context, true),
              ),
            ];
          },
        ) ??
        false);
  }
}
