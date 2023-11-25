import 'package:collection/collection.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';

class CurvedNavBarController
    extends StateNotifier<GlobalKey<CurvedNavigationBarState>> {
  static final log = logger(CurvedNavBarController);

  Map<String, int> routeIndexMap = {};
  Map<String, PageDefinition> routePageDefinitionMap = {};
  Map<int, PageDefinition> indexPageDefinitionMap = {};
  Ref ref;

  CurvedNavBarController(
    this.ref, {
    required AppDefinition appDefinition,
  }) : super(GlobalKey<CurvedNavigationBarState>()) {
    ref.listen(ApplicationSettings.debugMode.value, (_, debugMode) {
      _calculateMaps(appDefinition, debugMode);
    });
    final debugMode = ref.read(ApplicationSettings.debugMode.value);
    _calculateMaps(appDefinition, debugMode);
  }

  void _calculateMaps(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    log.d('Building Curved Nav Bar App Routes');
    final pages = appDefinition.pages.where(
      (page) => debugMode || !page.debug,
    );
    routeIndexMap = Map.fromEntries(
      pages.mapIndexed(
        (index, page) => MapEntry<String, int>(page.route, index),
      ),
    );
    routePageDefinitionMap = Map.fromEntries(
      pages.map(
        (page) => MapEntry<String, PageDefinition>(page.route, page),
      ),
    );
    indexPageDefinitionMap = Map.fromEntries(
      pages.mapIndexed(
        (index, page) => MapEntry<int, PageDefinition>(index, page),
      ),
    );
    state = GlobalKey<CurvedNavigationBarState>();
  }

  PageDefinition? getPageByIndex(int index) {
    return indexPageDefinitionMap[index];
  }

  int? getIndexByRoute(String route) {
    return routeIndexMap[route];
  }

  void changePage(String routeName) {
    final newIndex = routeIndexMap[routeName];
    if (newIndex != null) {
      state.currentState?.setPage(newIndex);
    }
  }

  List<PageDefinition> getPages() {
    return routePageDefinitionMap.values.toList();
  }
}
