import 'dart:async';

import 'package:feedback/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/date_symbol_data_local.dart';
import 'package:moonspace/controller/app_scroll_behavior.dart';
import 'package:moonspace/feedback/feedback_form.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:moonspace/helper/validator/debug_functions.dart';
import 'package:moonspace/provider/pref.dart';
import 'package:moonspace/theme.dart';
import 'package:moonspace/provider/global_theme.dart';

class Electric {
  static final GlobalKey<NavigatorState> electricOverlayKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> electricNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey();
  static const String moonspaceRestorationScopeId =
      'MoonSpaceRestorationScopeId';
  static const String appRestorationScopeId = 'AppRestorationScopeId';

  static BuildContext get overlayContext => electricOverlayKey.currentContext!;
  static BuildContext get navigatorContext =>
      electricNavigatorKey.currentContext!;
}

void electrify({
  required String title,
  // required GoRouter? router,
  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  final List<Locale>? supportedLocales,
  final List<AppTheme>? themes,
  required GoRouter Function(GlobalKey<NavigatorState> navigatorKey) router,
  required void Function(WidgetsBinding widgetsBinding) before,
  required void Function() after,
  required Widget Function(BuildContext context, Widget? child) wrap,
  required Future<void> Function(ProviderContainer providerContainer) init,
  required void Function(FlutterErrorDetails details) recordFlutterFatalError,
  required void Function(Object error, StackTrace stack) recordError,
  required bool debugUi,
}) async {
  runZonedGuarded(
    () async {
      // debugPaintSizeEnabled = true;
      // debugPaintLayerBordersEnabled = true;
      // debugRepaintRainbowEnabled = true;
      // debugPaintBaselinesEnabled = true;
      // debugPaintPointersEnabled = true;
      // debugPrintMarkNeedsLayoutStacks = true;
      // debugPrintMarkNeedsPaintStacks = true;

      //
      BindingBase.debugZoneErrorsAreFatal = true;
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      before(widgetsBinding);

      if (themes != null) {
        AppTheme.themes.addAll(themes);
      }

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);

      // ErrorWidget.builder = (FlutterErrorDetails details) {
      //   if (kDebugMode) {
      //     return ErrorPage(error: details);
      //   }
      //   return const SizedBox();
      // };

      // This captures errors reported by the Flutter framework.
      FlutterError.onError = (FlutterErrorDetails details) async {
        final dynamic exception = details.exception;
        final StackTrace? stackTrace = details.stack;

        if (kDebugMode) {
          FlutterError.presentError(details);
          debugPrint(exception.toString());
          debugPrintStack(stackTrace: stackTrace);
        } else {
          if (Device.isMobile) {
            recordFlutterFatalError(details);
          }

          Zone.current.handleUncaughtError(exception, stackTrace!);
        }
      };

      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        if (kDebugMode) {
          debugPrint(error.toString());
          debugPrintStack(stackTrace: stack);
        } else {
          if (Device.isMobile) {
            recordError(error, stack);
          }
        }
        return true;
      };

      //-----

      // ignore: missing_provider_scope
      // runApp(const SplashPage(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Image.asset(Asset.spaceMoon),
      //       Text('Built by shark.run', style: context.tm),
      //     ],
      //   ),
      // ));

      final container = ProviderContainer();

      container.listen(prefProvider, (prev, next) {});

      await init(container);

      await Future.delayed(const Duration(milliseconds: 100));

      runApp(
        UncontrolledProviderScope(
          container: container,
          child: BetterFeedback(
            feedbackBuilder: (context, onSubmit, scrollController) {
              return FeedbackForm(
                onSubmit: onSubmit,
                scrollController: scrollController,
              );
            },
            theme: FeedbackThemeData(),
            localizationsDelegates: [GlobalFeedbackLocalizationsDelegate()],
            child: MoonSpaceHome(
              title: title,
              router: router(Electric.electricNavigatorKey),
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              wrap: wrap,
              debugUi: debugUi,
            ),
          ),
        ),
      );

      after();
    },
    (error, stack) {
      if (kDebugMode) {
        debugPrint(error.toString());
        debugPrintStack(stackTrace: stack);
      } else {
        if (Device.isMobile) {
          recordError(error, stack);
        }
      }
    },
  );
}

class MoonSpaceHome extends ConsumerWidget {
  const MoonSpaceHome({
    super.key,
    required this.router,
    required this.title,
    this.localizationsDelegates,
    this.supportedLocales,
    required this.debugUi,
    required this.wrap,
  });

  final String title;

  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final List<Locale>? supportedLocales;

  final GoRouter? router;

  final bool debugUi;

  final Widget Function(BuildContext context, Widget? child) wrap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalAppTheme = ref.watch(globalThemeProvider);

    return RootRestorationScope(
      restorationId: Electric.moonspaceRestorationScopeId,
      child: LayoutBuilder(
        builder: (context, constraints) {
          AppTheme.currentTheme = AppTheme.currentTheme.copyWith(
            size: constraints.biggest,
          );

          dino('MoonSpace Rebuild ${constraints.biggest} \n');

          return CupertinoTheme(
            data: CupertinoThemeData(
              brightness: globalAppTheme.type.brightness,
              primaryColor: globalAppTheme.primary,
            ),
            child: MaterialApp.router(
              routerConfig: router,
              title: title,
              scaffoldMessengerKey: Electric.scaffoldMessengerKey,

              theme: AppTheme.currentTheme.theme,
              themeAnimationCurve: Curves.ease,
              debugShowCheckedModeBanner: debugUi,
              restorationScopeId: Electric.appRestorationScopeId,
              scrollBehavior: AppScrollBehavior(),

              // showSemanticsDebugger: true,
              // showPerformanceOverlay: true,
              supportedLocales: [Locale('en', 'US'), ...?supportedLocales],
              localizationsDelegates: localizationsDelegates,

              builder: (context, child) {
                initializeDateFormatting();

                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: Scaffold(
                    key: ValueKey(globalAppTheme.type),
                    resizeToAvoidBottomInset: false,
                    body: Overlay(
                      initialEntries: [
                        OverlayEntry(
                          builder: (context) {
                            return Builder(
                              key: Electric.electricOverlayKey,
                              builder: (context) {
                                return wrap(context, child);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DebugRouteOverlay extends StatelessWidget {
  final Widget child;

  const DebugRouteOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return child;

    return Stack(
      children: [
        child,
        Builder(
          builder: (context) {
            final location = GoRouter.of(context).state.uri;
            return Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Route: $location',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
