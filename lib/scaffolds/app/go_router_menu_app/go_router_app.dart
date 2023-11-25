import 'package:color_blindness/color_blindness.dart';
import 'package:color_blindness/color_blindness_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_platform/app_scaffold_features.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/cross_fade_transition_builder.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/scaffold_builder.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/page_definition_scaffold.dart';
import 'package:wt_logging/wt_logging.dart';

class GoRouterMenuApp extends ConsumerStatefulWidget {
  static final log = logger(GoRouterMenuApp, level: Level.debug);

  static final AppStyles styles = AppStyles(
    theme: ThemeData(
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CrossFadeTransitionBuilder(),
          TargetPlatform.iOS: CrossFadeTransitionBuilder(),
          TargetPlatform.macOS: CrossFadeTransitionBuilder(),
        },
      ),
      tabBarTheme: const TabBarTheme(
        labelPadding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
      ),
    ),
  );

  static final goRouter = Provider<GoRouter>(
    name: 'GoRouter',
    (ref) {
      final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
      return GoRouter(
        initialLocation: _createInitialRoute(appDefinition),
        routes: appDefinition.pages.map(
          (page) {
            log.d('Creating Route(${page.route}) : ${page.title}');
            return GoRoute(
              path: page.route,
              builder: (context, state) {
                return _PageWrapper(
                  page: page,
                  state: state,
                );
              },
            );
          },
        ).toList(),
      );
    },
  );

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

  static String _createInitialRoute(AppDefinition appDefinition) {
    final initialRoutePage =
        appDefinition.pages.where((page) => page.landing).firstOrNull ??
            appDefinition.pages.where((page) => page.primary).firstOrNull;
    if (initialRoutePage != null) {
      // return BottomMenuBar.createRouteName(initialRoutePage);
      return initialRoutePage.route;
    }
    throw Exception(
      'Could not determine the initial route for the application',
    );
  }
}

class _GoRouterAppState extends ConsumerState<GoRouterMenuApp> {
  static final log = logger(GoRouterMenuApp, level: Level.debug);

  @override
  Widget build(BuildContext context) {
    final isLoginEnabled = AppScaffoldFeatures.loginIsAvailable(context);
    log.d('LOGIN SUPPORT: $isLoginEnabled');
    final goRouter = ref.read(GoRouterMenuApp.goRouter);
    final appStyles = ref.read(AppScaffoldProviders.appStyles);
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final seedColor = widget.appDefinition.colorScheme == null
        ? ref.watch(ApplicationSettings.colorScheme.value)
        : widget.appDefinition.colorScheme!;
    final themeMode = widget.appDefinition.themeMode ??
        ref.watch(ApplicationSettings.theme.value);
    final colorBlindness = ref.watch(ApplicationSettings.colorBlindness.value);
    final locale = ref.watch(LocaleStore.provider);
    final locales =
        appDefinition.inltLocales ?? const <Locale>[Locale('en', 'US')];
    return MaterialApp.router(
      title: appDefinition.appTitle,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ref.read(UserLog.snackBarKey),
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
        if (appDefinition.intlDelegates != null)
          ...appDefinition.intlDelegates!,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: locales,
      locale: locale ?? locales.first,
    );
  }
}

class _PageWrapper extends ConsumerWidget {
  static final scaffoldBuilders = <ScaffoldType, ScaffoldBuilder>{
    ScaffoldType.plain: (context, page, state) =>
        page.builder(context, page, null),
    ScaffoldType.transparentCard: (context, page, state) =>
        PageDefinitionScaffold(pageDefinition: page, state: state),
  };

  final PageDefinition page;
  final GoRouterState state;
  const _PageWrapper({
    required this.page,
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MediaQueryData data = MediaQuery.of(context);
    final scaleFactor =
        ref.watch(ApplicationSettings.textScaleFactor.value).value;
    return SafeArea(
      child: MediaQuery(
        data: data.copyWith(
          textScaler: TextScaler.linear(scaleFactor),
        ),
        child: (scaffoldBuilders.containsKey(page.scaffoldType))
            ? scaffoldBuilders[page.scaffoldType]!.call(context, page, state)
            : page.builder(context, page, state),
      ),
    );
  }
}
