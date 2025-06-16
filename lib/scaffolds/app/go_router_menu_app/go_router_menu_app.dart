import 'package:color_blindness/color_blindness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffold_store.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/scaffold_app_go_router.dart';
import 'package:wt_logging/wt_logging.dart';

class GoRouterMenuApp extends ConsumerStatefulWidget {
  static final log = logger(GoRouterMenuApp);

  final AppDefinition appDefinition;
  final bool debugMode;

  const GoRouterMenuApp._({
    required this.appDefinition,
    required this.debugMode,
  });

  factory GoRouterMenuApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    return GoRouterMenuApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
    );
  }

  @override
  ConsumerState<GoRouterMenuApp> createState() => _GoRouterAppState();
}

class _GoRouterAppState extends ConsumerState<GoRouterMenuApp> {
  static final log = logger(GoRouterMenuApp);

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.read(ScaffoldAppGoRouter.goRouter);
    final appStyles = ref.read(AppScaffoldStore.appStyles);
    final appDefinition = ref.read(AppDefinition.provider);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final seedColor = appDefinition.colorScheme == null
        ? ref.watch(ApplicationSettings.colorScheme.value)
        : appDefinition.colorScheme!;

    final themeMode = appDefinition.themeMode ?? ref.watch(ApplicationSettings.theme.value);
    final colorBlindness = ref.watch(ApplicationSettings.colorBlindness.value);
    final locale = ref.watch(LocaleStore.provider);
    final locales = appDefinition.intlLocales ?? const <Locale>[Locale('en', 'US')];

    final snackBarKey = ref.watch(AppScaffoldStore.snackBarKey);

    log.d('===> BUILD MaterialApp');
    return MaterialApp.router(
      title: appDefinition.appDetails.title,
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
