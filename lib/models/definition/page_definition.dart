import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/models/definition/info/page_info.dart';
import 'package:wt_app_scaffold/models/definition/item_definition.dart';
import 'package:wt_app_scaffold/models/drawer_builder.dart';
import 'package:wt_app_scaffold/models/page_builder.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/item_control_panel.dart';
import 'package:wt_logging/wt_logging.dart';

class PageDefinition extends ItemDefinition<PageInfo> {
  static final log = logger(PageDefinition);

  final List<PageDefinition> childPages;

  final PageInfo? homeRoute;
  final bool centerTitle;
  final bool showAppBar;
  final bool hideBackButton;
  final bool showBottomMenu;
  final bool registerChildRoutes;

  final AppScaffoldPageBuilder? pageBuilder;
  final AppScaffoldPageBuilder? pageContentBuilder;
  final DrawerBuilder? drawerBuilder;
  final ScaffoldPageType? scaffoldType;

  final AppScaffoldActionProviders actionsProviders;
  final AppScaffoldSettingsMapProviders settingsProviders;

  const PageDefinition({
    required super.info,
    this.pageBuilder,
    this.pageContentBuilder,
    this.drawerBuilder,
    this.childPages = const [],
    this.scaffoldType,
    this.centerTitle = true,
    this.showAppBar = false,
    this.showBottomMenu = false,
    this.registerChildRoutes = false,
    this.homeRoute,
    this.actionsProviders = const [],
    this.settingsProviders = const {},
    this.hideBackButton = false,
  });

  PageDefinition copyWith({
    PageInfo? info,
    String? name,
    String? title,
    String? route,
    String? tabTitle,
    IconData? icon,
    ItemType? itemType,
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
      info: this.info.copyWith(
            name: name,
            title: title,
            tabTitle: tabTitle,
            icon: icon,
            route: route,
            itemType: itemType,
            info: info,
          ),
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PageDefinition && runtimeType == other.runtimeType && info == other.info;

  @override
  int get hashCode => info.hashCode;

  factory PageDefinition.combine(
    PageInfo info, {
    bool centerTitle = false,
    bool showAppBar = false,
    bool hideBackButton = true,
    bool showBottomMenu = false,
    bool registerChildRoutes = true,
    AppScaffoldPageBuilder? pageBuilder,
    AppScaffoldPageBuilder? pageContentBuilder,
    DrawerBuilder? drawerBuilder,
    ScaffoldPageType? scaffoldType,
    PageInfo? homeRoute,
    List<PageDefinition> pages = const [],
  }) =>
      PageDefinition(
        info: info,
        centerTitle: centerTitle,
        showAppBar: showAppBar,
        hideBackButton: hideBackButton,
        showBottomMenu: showBottomMenu,
        registerChildRoutes: registerChildRoutes,
        pageBuilder: pageBuilder,
        pageContentBuilder: pageContentBuilder,
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
      itemInfo: info,
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

  bool get isPrimary => info.itemType == ItemType.primary;
  bool get isSecondary => info.itemType == ItemType.secondary;
  bool get isHidden => info.itemType == ItemType.hidden;
  bool get isLanding => info.landing;
  bool get isDebug => info.debug;
}

extension AppScaffoldPageDefinitionListExtension on List<PageDefinition> {
  List<PageDefinition> whereRouteIs(List<String> requiredRoutes) {
    return where(
      (p) => requiredRoutes.contains(p.info.route),
    ).toList();
  }

  List<PageDefinition> copyWith({
    PageInfo? homeRoute,
    bool? hideBackButton,
    ScaffoldPageType? scaffoldType,
    bool? showBottomMenu,
    bool? landing,
    ItemType? itemType,
  }) {
    return map((p) => p.copyWith(
          homeRoute: homeRoute ?? p.homeRoute,
          hideBackButton: hideBackButton ?? p.hideBackButton,
          scaffoldType: scaffoldType ?? p.scaffoldType,
          showBottomMenu: showBottomMenu ?? p.showBottomMenu,
          itemType: itemType ?? p.info.itemType,
        )).toList();
  }

  List<PageDefinition> getPrimaryPages() => byType(ItemType.primary);
  List<PageDefinition> getSecondaryPages() => byType(ItemType.secondary);
  List<PageDefinition> getHiddenPages() => byType(ItemType.hidden);

  List<PageDefinition> byType(ItemType type) => where((page) => page.info.itemType == type).toList();
}
