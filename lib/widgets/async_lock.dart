import 'package:flutter/material.dart';

class AsyncLock<T> extends StatefulWidget {
  const AsyncLock({super.key, required this.builder});

  final Widget Function(
    bool loading,
    T? status,
    void Function() lock,
    void Function() unlock,
    void Function(T? status) setStatus,
  )
  builder;

  @override
  State<AsyncLock<T>> createState() => _AsyncLockState<T>();
}

class _AsyncLockState<T> extends State<AsyncLock<T>> {
  bool loading = false;
  T? status;

  @override
  Widget build(BuildContext context) {
    void setStatus(T? s) {
      status = s;
      if (mounted) {
        setState(() {});
      }
    }

    void lock() {
      loading = true;
      if (mounted) {
        setState(() {});
      }
    }

    void open() {
      loading = false;
      if (mounted) {
        setState(() {});
      }
    }

    return IgnorePointer(
      ignoring: loading,
      child: widget.builder(loading, status, lock, open, setStatus),
    );
  }
}
