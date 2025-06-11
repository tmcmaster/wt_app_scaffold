import 'package:collection/collection.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/scaffolds/common/types/app_scaffold_router.dart';
import 'package:wt_logging/wt_logging.dart';

class CurvedNavBarController extends StateNotifier<GlobalKey<CurvedNavigationBarState>> with AppScaffoldRouter {
  static final log = logger(CurvedNavBarController);

  Map<String, int> routeIndexMap = {};
  Map<String, PageDefinition> routePageDefinitionMap = {};
  Map<int, PageDefinition> indexPageDefinitionMap = {};
  Ref ref;

  CurvedNavBarController(this.ref) : super(GlobalKey<CurvedNavigationBarState>()) {
    ref.listen(AppDefinition.provider, (previous, appDefinition) {
      _calculateMaps(appDefinition.primaryPages);
      state = GlobalKey<CurvedNavigationBarState>();
    });
    _calculateMaps(ref.read(AppDefinition.provider).primaryPages);
    state = GlobalKey<CurvedNavigationBarState>();
  }

  void _calculateMaps(
    List<PageDefinition> pages,
  ) {
    log.d('Building Curved Nav Bar App Routes');
    routeIndexMap = Map.fromEntries(
      pages.mapIndexed(
        (index, page) => MapEntry<String, int>(page.info.route, index),
      ),
    );
    routePageDefinitionMap = Map.fromEntries(
      pages.map(
        (page) => MapEntry<String, PageDefinition>(page.info.route, page),
      ),
    );
    indexPageDefinitionMap = Map.fromEntries(
      pages.mapIndexed(
        (index, page) => MapEntry<int, PageDefinition>(index, page),
      ),
    );
  }

  List<PageDefinition> getPages() {
    return routePageDefinitionMap.values.toList();
  }

  PageDefinition? getPageByIndex(int index) {
    return indexPageDefinitionMap[index];
  }

  int? getIndexByRoute(String route) {
    return routeIndexMap[route];
  }

  void changePageIndex(int newIndex) {
    state.currentState?.setPage(newIndex);
  }

  void changePage(String routeName) {
    final newIndex = routeIndexMap[routeName];
    if (newIndex != null) {
      state.currentState?.setPage(newIndex);
    }
  }

  @override
  void push(String path, {Object? extra}) {
    go(path, extra: extra);
  }

  @override
  void go(String path, {Object? extra}) {
    changePage(path);
  }
}
