import 'package:color_blindness/color_blindness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffold_store.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/scaffold_app_go_router.dart';
import 'package:wt_app_scaffold/scaffolds/common/types/app_scaffold_router.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/scaffold_page_type_wrapper.dart';
import 'package:wt_logging/wt_logging.dart';

class GoRouterMenuApp extends ConsumerStatefulWidget {
  static final log = logger(GoRouterMenuApp);

  static final router = Provider<AppScaffoldRouter>(
    name: 'GoRouter',
    (ref) => ScaffoldAppGoRouter(ref),
  );

  static final goRouter = Provider<GoRouter>(
    name: 'GoRouter',
    (ref) {
      final navigatorKey = ref.watch(AppScaffoldStore.navigatorKey);
      final appDefinition = ref.read(AppDefinition.provider);
      final initialRoute = _createInitialRoute(appDefinition);
      final redirectMap = _generateRedirectMap(appDefinition, {'/': initialRoute});

      return GoRouter(
        navigatorKey: navigatorKey,
        initialLocation: initialRoute,
        redirect: (context, state) => redirectMap[state.matchedLocation],
        routes: appDefinition.pages.map(
          (page) {
            log.d('Creating Route(${page.info.route}) : ${page.info.title}');
            return GoRoute(
                path: page.info.route,
                builder: (context, state) {
                  return ScaffoldPageTypeWrapper(
                    page: page,
                    state: state,
                    scaffoldPageType: page.scaffoldType,
                  );
                },
                routes: !page.registerChildRoutes || page.childPages.isEmpty
                    ? []
                    : page.childPages.map((childPage) {
                        log.d('Creating Child Route(${childPage.info.route}) : ${childPage.info.title}');
                        return GoRoute(
                          path: childPage.info.route,
                          builder: (context, state) {
                            return ScaffoldPageTypeWrapper(
                              page: childPage,
                              state: state,
                              scaffoldPageType: childPage.scaffoldType,
                            );
                          },
                        );
                      }).toList());
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
    final initialRoutePage = appDefinition.pages.where((page) => page.isLanding).firstOrNull ??
        appDefinition.pages.where((page) => page.isPrimary).firstOrNull;
    if (initialRoutePage != null) {
      return initialRoutePage.info.route;
    }
    throw Exception('Could not determine the initial route for the application');
  }

  static Map<String, String> _generateRedirectMap(AppDefinition appDefinition, Map<String, String> initialMap) {
    final map = <String, String>{
      ...initialMap,
    };

    void collect(PageDefinition parent) {
      for (int c = 0; c < parent.childPages.length; c++) {
        final child = parent.childPages[c];
        map[child.info.route] = '${parent.info.route}?tabIndex=${c + 1}';
        collect(child);
      }
    }

    for (final page in appDefinition.pages) {
      collect(page);
    }

    return map;
  }
}

class _GoRouterAppState extends ConsumerState<GoRouterMenuApp> {
  static final log = logger(GoRouterMenuApp);

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.read(GoRouterMenuApp.goRouter);
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
