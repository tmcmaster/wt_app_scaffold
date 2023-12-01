import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/app/application_settings.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldMaterialApp extends ConsumerWidget {
  static final log = logger(AppScaffoldMaterialApp, level: Level.debug);

  final Map<String, WidgetBuilder> routes;
  final String initialRoute;

  const AppScaffoldMaterialApp._({
    required this.initialRoute,
    required this.routes,
  });

  factory AppScaffoldMaterialApp.fromWidget(Widget widget) {
    return AppScaffoldMaterialApp.fromBuilder((_) => widget);
  }

  factory AppScaffoldMaterialApp.fromBuilder(WidgetBuilder builder) {
    return AppScaffoldMaterialApp._(
      initialRoute: '/',
      routes: {
        '/': builder,
      },
    );
  }

  factory AppScaffoldMaterialApp.fromRoutes({
    required Map<String, WidgetBuilder> routes,
    String? initialRoute,
  }) {
    if (routes.isEmpty) {
      throw Exception('The route map needs to have at least 1 entry.');
    }
    final calculatedInitialRoute =
        initialRoute ?? (routes.containsKey('/') ? '/' : routes.keys.first);
    return AppScaffoldMaterialApp._(
      routes: routes,
      initialRoute: calculatedInitialRoute,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final seedColor = appDefinition.colorScheme == null
        ? ref.watch(ApplicationSettings.colorScheme.value)
        : appDefinition.colorScheme!;

    log.d('Seed Color: $seedColor');
    log.d('Routes: $routes');

    final appStyles = ref.read(AppScaffoldProviders.appStyles);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);

    return MaterialApp(
      debugShowCheckedModeBanner: debugMode,
      scaffoldMessengerKey: ref.read(UserLog.snackBarKey),
      navigatorKey: ref.read(UserLog.navigatorKey),
      theme: appStyles.theme.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
      ),
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
