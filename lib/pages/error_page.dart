import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // GoRouterState state = GoRouterState.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text('${state.uri} does not exist'),
            if (child != null) child!,
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to home'),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});

  final dynamic error;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: SelectableText(
        (error is FlutterErrorDetails)
            ? error.exception.toString()
            : error.toString(),
        style: const TextStyle(color: Colors.purple),
        textDirection: TextDirection.ltr,
      ),

      // SelectableText(
      //   error.toString(),
      //   style: const TextStyle(color: Colors.amber),
      //   textDirection: TextDirection.ltr,
      // ),
      // if (error is FlutterError || error is FlutterErrorDetails)
      //   SelectableText(
      //     error is FlutterErrorDetails ? error.stack.toString() : error.stackTrace.toString(),
      //     style: const TextStyle(color: Colors.red),
      //     textDirection: TextDirection.ltr,
      //   ),
    );
  }
}
