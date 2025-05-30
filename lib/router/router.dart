import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension ValidateRouterState on GoRouterState {
  bool get isAuth => uri.path.contains('/auth');
  bool match(String path) => uri.path == path;
}

Page<void> fadePage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      CurvedAnimation curvedAnimation =
          CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);

      return FadeTransition(
        opacity: curvedAnimation,
        child: child,
      );
    },
  );
}
