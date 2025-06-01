import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/models/drawer_builder.dart';
import 'package:wt_app_scaffold/models/item_definition.dart';
import 'package:wt_app_scaffold/models/page_builder.dart';
import 'package:wt_app_scaffold/models/page_info.dart';
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

  final List<PageDefinition> childPages;
  final ScaffoldPageType? scaffoldType;
  final PageInfo? homeRoute;
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
            itemInfo: pageInfo,
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
  }) {
    return ItemControlPanel.from(
      itemInfo: pageInfo,
      actionsProviders: actionsProviders,
      settingsProviders: settingsProviders,
      initiallyExpanded: initiallyExpanded,
      type: type,
    );
  }
}
