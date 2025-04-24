import 'package:color_blindness/color_blindness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldGoRouterApp extends ConsumerWidget {
  static final log = logger(AppScaffoldGoRouterApp, level: Level.debug);

  const AppScaffoldGoRouterApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.read(GoRouterMenuApp.goRouter);
    final appStyles = ref.read(AppScaffoldProviders.appStyles);
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final seedColor = appDefinition.colorScheme == null
        ? ref.watch(ApplicationSettings.colorScheme.value)
        : appDefinition.colorScheme!;
    log.d('Seed Color: $seedColor');
    final themeMode = appDefinition.themeMode ?? ref.watch(ApplicationSettings.theme.value);
    final colorBlindness = ref.watch(ApplicationSettings.colorBlindness.value);
    final locale = ref.watch(LocaleStore.provider);
    final locales = appDefinition.inltLocales ?? const <Locale>[Locale('en', 'US')];

    final snackBarKey = ref.watch(AppScaffoldProviders.snackBarKey);
    log.d('===> BUILD MaterialApp');
    return MaterialApp.router(
      title: appDefinition.appTitle,
      debugShowCheckedModeBanner: debugMode,
      scaffoldMessengerKey: snackBarKey,
      themeMode: themeMode,
      theme: appStyles.theme.copyWith(
        colorScheme: colorBlindness == ColorBlindnessType.none
            ? ColorScheme.fromSeed(seedColor: seedColor)
            : colorBlindnessColorScheme(
                ColorScheme.fromSeed(seedColor: seedColor),
                colorBlindness,
              ),
        extensions: [
          appStyles.spacing,
          appStyles.sizing,
        ],
      ),
      darkTheme: appStyles.darkTheme,
      routerConfig: goRouter,
      localizationsDelegates: [
        ...appDefinition.intlDelegates,
      ],
      supportedLocales: locales,
      locale: locale ?? locales.first,
    );
  }
}
