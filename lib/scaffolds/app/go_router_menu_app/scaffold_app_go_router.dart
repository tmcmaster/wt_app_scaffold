import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/providers/app_scaffold_store.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/route_state_store.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/scaffold_page_type_wrapper.dart';
import 'package:wt_logging/wt_logging.dart';

class ScaffoldAppGoRouter with AppDefinitionRouter {
  static final log = logger(ScaffoldAppGoRouter);

  static final router = Provider<AppDefinitionRouter>(
    name: 'GoRouter',
    (ref) => ScaffoldAppGoRouter(ref),
  );

  static final goRouter = Provider<GoRouter>(
    name: 'GoRouter',
    (ref) {
      final navigatorKey = ref.watch(AppScaffoldStore.navigatorKey);
      final appDefinition = ref.read(AppDefinition.provider);

      final pages = appDefinition.pages;

      final initialRoute = _createInitialRoute(pages);
      final redirectMap = _generateRedirectMap(pages, {'/': initialRoute});

      return GoRouter(
        navigatorKey: navigatorKey,
        initialLocation: initialRoute,
        redirect: (context, state) => redirectMap[state.matchedLocation],
        routes: pages.map(
          (page) {
            log.d('Creating Route(${page.info.route}) : ${page.info.title}');
            return GoRoute(
                path: page.info.route,
                builder: (context, state) {
                  return ScaffoldPageTypeWrapper(
                    page: page,
                    state: state,
                    scaffoldPageType: page.pageType,
                  );
                },
                routes: !page.registerChildRoutes || page.childPages.isEmpty
                    ? []
                    : page.childPages.map((childPage) {
                        log.d('Creating Child Route(${childPage.info.route}) : ${childPage.info.title}');
                        return GoRoute(
                          path: childPage.info.name,
                          builder: (context, state) {
                            return ScaffoldPageTypeWrapper(
                              page: childPage,
                              state: state,
                              scaffoldPageType: childPage.pageType,
                            );
                          },
                        );
                      }).toList());
          },
        ).toList(),
      );
    },
  );

  final Ref ref;

  ScaffoldAppGoRouter(this.ref);

  @override
  void go(String path, {Object? extra}) {
    _updateRouteState(path, extra);
    ref.read(goRouter).go(path, extra: extra);
  }

  @override
  void push(String path, {Object? extra}) {
    _updateRouteState(path, extra);
    ref.read(goRouter).push(path, extra: extra);
  }

  void _updateRouteState(String path, Object? extra) {
    final tab = extra != null && extra is int ? extra : 0;
    ref.read(RouteStateStore.provider.notifier).setCurrentRoute(path, tab);
  }

  static String _createInitialRoute(List<PageDefinition> pages) {
    final initialRoutePage =
        pages.where((page) => page.isLanding).firstOrNull ?? pages.where((page) => page.isPrimary).firstOrNull;
    if (initialRoutePage != null) {
      return initialRoutePage.info.route;
    }
    throw Exception('Could not determine the initial route for the application');
  }

  static Map<String, String> _generateRedirectMap(List<PageDefinition> pages, Map<String, String> initialMap) {
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

    for (final page in pages) {
      collect(page);
    }

    return map;
  }
}
