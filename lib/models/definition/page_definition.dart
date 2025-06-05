import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/models/definition/info/page_info.dart';
import 'package:wt_app_scaffold/models/drawer_builder.dart';
import 'package:wt_app_scaffold/models/item_definition.dart';
import 'package:wt_app_scaffold/models/page_builder.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/item_control_panel.dart';
import 'package:wt_logging/wt_logging.dart';

class PageDefinition extends ItemDefinition {
  static final log = logger(PageDefinition);

  final bool landing;
  final bool centerTitle;
  final bool showAppBar;
  final bool hideBackButton;
  final bool showBottomMenu;
  final bool registerChildRoutes;

  final AppScaffoldPageBuilder? pageBuilder;
  final AppScaffoldPageBuilder? pageContentBuilder;
  final Widget Function()? pageBodyBuilder;
  final DrawerBuilder? drawerBuilder;
  final ScaffoldPageType? scaffoldType;
  final PageInfo? homeRoute;

  final List<PageDefinition> childPages;
  final AppScaffoldActionProviders actionsProviders;
  final AppScaffoldSettingsMapProviders settingsProviders;

  const PageDefinition({
    required super.pageInfo,
    super.primary,
    super.debug,
    this.pageBuilder,
    this.pageContentBuilder,
    this.drawerBuilder,
    this.landing = false,
    this.childPages = const [],
    this.scaffoldType,
    this.centerTitle = true,
    this.showAppBar = false,
    this.showBottomMenu = false,
    this.registerChildRoutes = false,
    this.homeRoute,
    this.actionsProviders = const [],
    this.settingsProviders = const {},
    this.pageBodyBuilder,
    this.hideBackButton = false,
  });

  String get route => '/${pageInfo.name}';

  factory PageDefinition.combine(
    PageInfo pageInfo, {
    bool landing = false,
    bool centerTitle = false,
    bool showAppBar = false,
    bool hideBackButton = true,
    bool showBottomMenu = false,
    bool registerChildRoutes = true,
    AppScaffoldPageBuilder? pageBuilder,
    AppScaffoldPageBuilder? pageContentBuilder,
    Widget Function()? pageBodyBuilder,
    DrawerBuilder? drawerBuilder,
    ScaffoldPageType? scaffoldType,
    PageInfo? homeRoute,
    List<PageDefinition> pages = const [],
  }) =>
      PageDefinition(
        pageInfo: pageInfo,
        landing: landing,
        centerTitle: centerTitle,
        showAppBar: showAppBar,
        hideBackButton: hideBackButton,
        showBottomMenu: showBottomMenu,
        registerChildRoutes: registerChildRoutes,
        pageBuilder: pageBuilder,
        pageContentBuilder: pageContentBuilder,
        pageBodyBuilder: pageBodyBuilder,
        drawerBuilder: drawerBuilder,
        scaffoldType: scaffoldType,
        homeRoute: homeRoute,
        childPages: [...pages.map((page) => page.childPages).expand((e) => e)],
        actionsProviders: [
          ...pages.map((page) => page.actionsProviders).expand((e) => e),
        ],
        settingsProviders: Map.fromEntries([
          ...pages.map((page) => page.settingsProviders.entries),
        ].expand((e) => e)),
      );

  PageDefinition copyWith({
    PageInfo? pageInfo,
    String? name,
    String? title,
    String? tabTitle,
    IconData? icon,
    bool? primary,
    bool? debug,
    bool? landing,
    AppScaffoldPageBuilder? pageBuilder,
    AppScaffoldPageBuilder? pageContentBuilder,
    DrawerBuilder? drawerBuilder,
    List<PageDefinition>? childPages,
    ScaffoldPageType? scaffoldType,
    bool? centerTitle,
    bool? showAppBar,
    bool? showBottomMenu,
    bool? hideBackButton,
    PageInfo? homeRoute,
    AppScaffoldActionProviders? actionsProviders,
    AppScaffoldSettingsMapProviders? settingsProviders,
  }) {
    return PageDefinition(
      pageInfo: this.pageInfo.copyWith(
            name: name,
            title: title,
            tabTitle: tabTitle,
            icon: icon,
            pageInfo: pageInfo,
          ),
      primary: primary ?? this.primary,
      debug: debug ?? this.debug,
      landing: landing ?? this.landing,
      pageBuilder: pageBuilder ?? this.pageBuilder,
      pageContentBuilder: pageContentBuilder ?? this.pageContentBuilder,
      drawerBuilder: drawerBuilder ?? this.drawerBuilder,
      childPages: childPages ?? this.childPages,
      scaffoldType: scaffoldType ?? this.scaffoldType,
      centerTitle: centerTitle ?? this.centerTitle,
      showAppBar: showAppBar ?? this.showAppBar,
      hideBackButton: hideBackButton ?? this.hideBackButton,
      showBottomMenu: showBottomMenu ?? this.showBottomMenu,
      homeRoute: homeRoute ?? this.homeRoute,
      actionsProviders: actionsProviders ?? this.actionsProviders,
      settingsProviders: settingsProviders ?? this.settingsProviders,
    );
  }

  ItemControlPanel createControlPanel({
    bool initiallyExpanded = false,
    ItemControlPanelType type = ItemControlPanelType.expandableAll,
    bool enableRoute = false,
    bool childExpanded = false,
    ItemControlPanelType childType = ItemControlPanelType.expandableAll,
    List<ItemControlPanel> Function()? buildChildren,
    Widget Function()? summaryBuilder,
  }) {
    return ItemControlPanel.from(
      itemInfo: pageInfo,
      actionsProviders: actionsProviders,
      settingsProviders: settingsProviders,
      initiallyExpanded: initiallyExpanded,
      type: type,
      enableRoute: enableRoute,
      childExpanded: childExpanded,
      childType: childType,
      buildChildren: buildChildren,
      summaryBuilder: summaryBuilder,
    );
  }

  bool get isPrimary => pageInfo.itemType == ItemType.primary;
  bool get isSecondary => pageInfo.itemType == ItemType.secondary;
  bool get isHidden => pageInfo.itemType == ItemType.hidden;
}

extension AppScaffoldPageDefinitionListExtension on List<PageDefinition> {
  List<PageDefinition> whereRouteIs(List<String> testRoutes) {
    return where(
      (p) => testRoutes.contains(p.route),
    )
        .map((p) => p.copyWith(primary: true))
        .mapIndexed((i, p) => i == 0
            ? p.copyWith(
                landing: true,
              )
            : p)
        .toList();
  }

  List<PageDefinition> copyWith({
    bool? primary,
    PageInfo? homeRoute,
    bool? hideBackButton,
    ScaffoldPageType? scaffoldType,
    bool? showBottomMenu,
    bool? isHidden,
  }) {
    return map((p) => p.copyWith(
          primary: primary ?? p.primary,
          homeRoute: homeRoute ?? p.homeRoute,
          hideBackButton: hideBackButton ?? p.hideBackButton,
          scaffoldType: scaffoldType ?? p.scaffoldType,
          showBottomMenu: showBottomMenu ?? p.showBottomMenu,
        )).toList();
  }

  List<PageDefinition> getPrimaryPages() => byType(ItemType.primary);
  List<PageDefinition> getSecondaryPages() => byType(ItemType.secondary);
  List<PageDefinition> getHiddenPages() => byType(ItemType.hidden);

  List<PageDefinition> byType(ItemType type) => where((page) => page.pageInfo.itemType == type).toList();
}
