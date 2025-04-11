import 'package:color_blindness/color_blindness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/app_platform/widget/app_scaffold_go_router_app.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_scaffold_page_context.dart';
import 'package:wt_app_scaffold/models/page_builder.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/page_definition_scaffold.dart';
import 'package:wt_logging/wt_logging.dart';

class ScaffoldAppGoRouter with AppScaffoldRouter {
  final Ref ref;
  ScaffoldAppGoRouter(this.ref);

  @override
  void go(String path, {Object? extra}) {
    ref.read(GoRouterMenuApp.goRouter).go(path, extra: extra);
  }
}

class GoRouterMenuApp extends ConsumerStatefulWidget {
  static final log = logger(GoRouterMenuApp, level: Level.debug);

  static final router = Provider<AppScaffoldRouter>(
    name: 'GoRouter',
    (ref) => ScaffoldAppGoRouter(ref),
  );

  static final goRouter = Provider<GoRouter>(
    name: 'GoRouter',
    (ref) {
      final navigatorKey = ref.watch(AppScaffoldProviders.navigatorKey);
      final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
      return GoRouter(
        navigatorKey: navigatorKey,
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
                  scaffoldPageType: appDefinition.scaffoldPageType,
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
    final initialRoutePage = appDefinition.pages.where((page) => page.landing).firstOrNull ??
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
    return const AppScaffoldGoRouterApp();
  }

  Widget buildHold(BuildContext context) {
    final goRouter = ref.read(GoRouterMenuApp.goRouter);
    final appStyles = ref.read(AppScaffoldProviders.appStyles);
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final seedColor = widget.appDefinition.colorScheme == null
        ? ref.watch(ApplicationSettings.colorScheme.value)
        : widget.appDefinition.colorScheme!;
    log.d('Seed Color: $seedColor');
    final themeMode = widget.appDefinition.themeMode ?? ref.watch(ApplicationSettings.theme.value);
    final colorBlindness = ref.watch(ApplicationSettings.colorBlindness.value);
    final locale = ref.watch(LocaleStore.provider);
    final locales = appDefinition.inltLocales ?? const <Locale>[Locale('en', 'US')];

    final snackBarKey = ref.watch(AppScaffoldProviders.snackBarKey);

    log.d('===> BUILD_HOLD MaterialApp');
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
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: locales,
      locale: locale ?? locales.first,
    );
  }
}

class _PageWrapper extends ConsumerWidget {
  static final scaffoldBuilders = <ScaffoldPageType, AppScaffoldPageBuilder>{
    ScaffoldPageType.plain: (pageContext) => pageContext.page.builder(pageContext),
    ScaffoldPageType.transparentCard: (pageContext) => PageDefinitionScaffold(
          pageDefinition: pageContext.page,
          state: pageContext.state,
        ),
  };

  final PageDefinition page;
  final GoRouterState state;
  final ScaffoldPageType? scaffoldPageType;
  const _PageWrapper({
    required this.page,
    required this.state,
    this.scaffoldPageType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MediaQueryData data = MediaQuery.of(context);
    final scaleFactor = ref.watch(ApplicationSettings.textScaleFactor.value).value;
    final calculatedScaffoldPageType = page.scaffoldType ?? scaffoldPageType;
    final AppScaffoldPageBuilder pageBuilder = scaffoldBuilders[calculatedScaffoldPageType] ?? page.builder;
    return SafeArea(
      child: MediaQuery(
        data: data.copyWith(
          textScaler: TextScaler.linear(scaleFactor),
        ),
        child: pageBuilder(
          AppScaffoldPageContext(
            context: context,
            ref: ref,
            page: page,
            state: state,
          ),
        ),
      ),
    );
  }
}
