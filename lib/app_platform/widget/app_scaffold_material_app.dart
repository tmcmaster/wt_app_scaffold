import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldMaterialApp extends ConsumerWidget {
  static final log = logger(AppScaffoldMaterialApp, level: Level.warning);

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
    final calculatedInitialRoute = initialRoute ?? (routes.containsKey('/') ? '/' : routes.keys.first);
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

    final snackBarKey = ref.watch(AppScaffoldProviders.snackBarKey);
    final navigatorKey = ref.watch(AppScaffoldProviders.navigatorKey);

    final themeMode = appDefinition.themeMode ?? ref.watch(ApplicationSettings.theme.value);
    final locale = ref.watch(LocaleStore.provider);
    final locales = appDefinition.intlLocales ?? const <Locale>[Locale('en', 'US')];

    log.d('===> ROUTES MaterialApp');
    return MaterialApp(
      title: appDefinition.appTitle,
      debugShowCheckedModeBanner: debugMode,
      scaffoldMessengerKey: snackBarKey,
      navigatorKey: navigatorKey,
      themeMode: themeMode,
      theme: appStyles.theme,
      darkTheme: appStyles.darkTheme,
      initialRoute: initialRoute,
      routes: routes,
      localizationsDelegates: [
        ...appDefinition.intlDelegates,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: locales,
      locale: locale ?? locales.first,
    );
  }
}
