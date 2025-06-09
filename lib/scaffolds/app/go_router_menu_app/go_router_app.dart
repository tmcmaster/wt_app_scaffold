import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/app_scaffold_go_router_app.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/scaffold_app_go_router.dart';
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
      final navigatorKey = ref.watch(AppScaffoldProviders.navigatorKey);
      final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
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
  @override
  Widget build(BuildContext context) {
    return const AppScaffoldGoRouterApp();
  }
}
